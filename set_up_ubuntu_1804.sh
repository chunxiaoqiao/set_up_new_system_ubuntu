#!/bin/bash
#把软件源添加到国内
echo "Configuring system ..."
sudo apt-get upgrade
pwd
#gnome-terminal --tab  -- bash -c  "cd ../ ; pwd;exec bash"
echo "install cmake ..."
sudo apt-get install g++
sudo apt-get upgrade
sudo apt-get upgrade
sudo apt-get install make
tar -xvf cmake-3.18.4-Linux-x86_64.tar.gz cmake-3.18.4-Linux-x86_64/
sudo mv cmake-3.18.4-Linux-x86_64 /opt/cmake-3.18.4
sudo ln -sf /opt/cmake-3.18.4/bin/* /usr/bin/


echo "install gflag and glog ..."
unzip gflags-master.zip
cd gflags-master
mkdir build
cd build/
cmake .. -DCMAKE_CXX_FLAGS=-fPIC
sudo make -j8
sudo make install

cd ../../
unzip glog-master.zip
cd glog-master
cmake ./
make -j8
sudo make install
cd ../


echo "install eigen ..."
cd eigen-eigen-334/eigen-eigen-5a0156e40feb/
rm -r build 
mkdir build
cd build
cmake ..
sudo make install
sudo cp -r /usr/local/include/eigen3/Eigen /usr/local/include 
cd ../../../

echo "install ceres ..."
sudo apt-get install liblapack-dev libsuitesparse-dev -Y
#sudo apt-get install libcxsparse3 -Y
cd ceres-solver-1.12.0
rm -r build
mkdir build
cd build 
cmake ..
make -j16
sudo make install
cd ../../


echo "install g2o ..."
sudo apt-get install libsuitesparse-dev -y
sudo apt-get install qtdeclarative5-dev -y
sudo apt-get install libqt4-dev -y
sudo apt-get install qt4-qmake -y
sudo apt-get install libqglviewer-qt4-dev -y
sudo apt-get install libqglviewer-dev
sudo apt-get install libsuitesparse-dev qtdeclarative5-dev qt5-qmake -y #g2o_viewer 用
sudo apt-get install libqglviewer-dev-qt5 -y
cd g2o
rm -r build
mkdir build
cd build
cmake ../
make -j8
sudo make install
echo "include /usr/local/lib" >>/etc/ld.so.conf
ldconfig
cd ../../

echo "install opencv ..."  #要把contribute放到opencv解压后的文件夹里面 
sudo apt-get install libgtk2.0-dev -Y
sudo apt-get install build-essential -Y
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev -Y
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev -Y
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev -Y
sudo cp -r /usr/local/include/eigen3/unsupported/ /usr/local/include/   #copy eigen lib 
cd opencv-3.4.3/
rm -r build
mkdir build
cd build
cmake -DOPENCV_ENABLE_NONFREE:BOOL=ON  -D CMAKE_BUILD_TYPE=Release  -D BUILD_PNG=ON -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib-3.4.3/modules ..
make -j16
sudo make install
cd ../../
sudo gedit /etc/ld.so.conf.d/opencv.conf 
touch /etc/ld.so.conf.d/opencv.conf 
echo "/usr/local/lib" >>/etc/ld.so.conf.d/opencv.conf
sudo ldconfig
echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH" >>/etc/bash.bashrc
#cd ../samples/cpp/example_cmake/
#cmake ..
#make
#./opencv_example

echo "install sophus ..."#只需cmake即可
cd  Sophus-master/
sudo rm -r build
mkdir build
cd build 
cmake ..
cd ../../

if false ;then  #选择性执行  默认不执行  ，需要先把火狐浏览器的压缩包解压到当前文件夹下
echo "reinstall firefox ..."
sudo apt-get remove firefox
sudo mv firefox  /opt
sudo touch /usr/share/applications/firefox.desktop
echo "[Desktop Entry]
Name=firefox
Name[zh_CN]=火狐浏览器
Comment=火狐浏览器
Exec=/opt/firefox/firefox
#Icon=/opt/firefox/browser/icons/mozicon128.png #可能在其他位置
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Application
Encoding=UTF-8
StartupNotify=true" >>/usr/share/applications/firefox.desktop
fi


if false ;then
echo "install ros"
sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654 #秘钥提示错误可以尝试使用此命令 后面的字符串要视情况修改
sudo apt-get update 
sudo apt-get install ros-melodic-desktop-full
sudo apt-get install ros-melodic-rqt*
sudo rosdep init  #网不好就换网
rosdep update
sudo apt-get install python-rosinstall
echo "source /opt/ros/melodic/setup.bash" >>~/.bashrc
source ~/.bashrc
#roscore   rosrun turtlesim turtlesim_node  rosrun turtlesim turtle_teleop_key
fi

echo "install pangoling"
sudo apt-get install libglew-dev -y
sudo apt-get install libpython2.7-dev -y
sudo apt-get install ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev -y
sudo apt-get install libdc1394-22-dev libraw1394-dev -y
sudo apt-get install libjpeg-dev libpng12-dev libtiff5-dev libopenexr-dev -y
sudo apt-get install libboost-dev libboost-thread-dev libboost-filesystem-dev -y
#git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
mkdir build
cd build
cmake -DCPP11_NO_BOOST=1 ..
make -j8
sudo make install
cd ../../


#  export PATH=/home/qcx/softear/clion-2021.1.2/bin:${PATH}  #clion 路径

