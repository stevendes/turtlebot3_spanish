cmake_minimum_required(VERSION 3.0.2)
project(apriltag_simulation)

find_package(catkin REQUIRED)

# catkin_python_setup()

catkin_package()

#catkin_install_python(PROGRAMS
#    scripts/placeholder
#  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})

install(DIRECTORY launch models urdf worlds
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
