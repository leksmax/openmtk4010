pipeline {
  agent any
  stages {
    stage('Build openWRT') {
      parallel {
        stage('Build openWRT') {
          steps {
            sh '''ls -al
whoami'''
            echo 'Compile openWRT'
          }
        }
        stage('CPP Check') {
          steps {
            sh 'cppcheck  mtk-openwrt-4.0.1.0'
          }
        }
        stage('Build openWRT') {
          steps {
            sh '''echo "version check" 
./build.sh openwrt'''
          }
        }
      }
    }
    stage('Build Bootloader') {
      parallel {
        stage('Build Bootloader') {
          steps {
            echo 'TEST TODO'
            sh 'ls -al'
          }
        }
        stage('CPP Check') {
          steps {
            echo 'TODO'
          }
        }
      }
    }
    stage('Copy Image to tftpboot') {
      steps {
        sh '''whoami 
ls -al mtk-openwrt-4.0.1.0/bin/targets/mediatek/mt7622-glibc'''
        sh '''./build.sh openwrt-release
ls -al /tftpboot'''
      }
    }
  }
}