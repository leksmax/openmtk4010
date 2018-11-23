import os, sys
import shlex
import subprocess

FIREWALL_USER_FILE='/etc/firewall.user'
FIREWALL_USER_TEMP_FILE='/etc/firewall.user.temp'


CMD_OPTIONS='-S | grep -e "\-A DOCKER" -e "\N DOCKER" -e "\-j DOCKER"'

cmd_list = ['iptables ', 'iptables -t nat ', 'iptables -t mangle ']



def subprocess_open(command):
	popen = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
	(stdoutdata, stderrdata) = popen.communicate()
	return stdoutdata, stderrdata

def subprocess_pipe(cmd_list):
	prev_stdin = None
	last_p = None

	for str_cmd in cmd_list:
		cmd = str_cmd.split()
		last_p = subprocess.Popen(cmd, stdin=prev_stdin, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		prev_stdin = last_p.stdout

	(stdoutdata, stderrdata) = last_p.communicate()
	return stdoutdata, stderrdata

def iptables_get_docker_rule():
	wline = ''
	for iptable_cmd in cmd_list:
		cmd_str = iptable_cmd + CMD_OPTIONS
		output, error = subprocess_open(cmd_str)
		if error:
			print "error:%s"%error
			continue

		output = output.strip()
		if output == '': continue

		output = output.splitlines()
		for line in output:
			if 'DOCKER' in line:
				wline += iptable_cmd + str(line) + "\n"

	print "DOCKER IPTABLES:\n" + str(wline)
	return wline

def iptables_generate_firewall_user_file(docker_line):
	wline = ''
	comment_line = ''
	with open(FIREWALL_USER_FILE, "r") as rfile:
		lines = rfile.readlines()

		for line in lines:
			if 'DOCKER' in line:
				continue
			if line[0] == '#':
				comment_line += line
				continue
			wline += line

	with open (FIREWALL_USER_TEMP_FILE, "w") as wfile:
		wfile.write(comment_line)
		wfile.write(docker_line)
		wfile.write(wline)

	os.rename(FIREWALL_USER_TEMP_FILE, FIREWALL_USER_FILE)

'''
Main routine
'''
docker_line = iptables_get_docker_rule()
iptables_generate_firewall_user_file(docker_line)
