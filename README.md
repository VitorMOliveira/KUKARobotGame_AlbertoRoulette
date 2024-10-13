# KUKARobotGame_AlbertoRoulette

A KUKA Agilus 3 industrial robotic arm game based project for playing the roulette. 

The project uses a QT/QML interface and allows the players to choose the betting numbers of the roullette and pick the winner. 

The robot is equipped with a custom made gripper that allows to hold an eletromagnet to pick the ball and a ESPCAM microcontroller to take photos of the game. 
The ESPCAM allows the robot gripper to align with the roulette dinamically and also to see where the ball falled in the roulette.

The roulette axis is attached to a DC Motor controlled by a ESP32 microcontroller to make the roulette spin while the robot is throwing the ball.

A computer vision + OCR script in Python was developed to detect the ball and the roulette number picked from the image taken with the ESPCAM.

The QT/QML interface, that is the central system of the game, communicates with the robot arm + ESP32 and the ESPCAM microcontrollers + the Python computer vision script to control the flow of the game.

### Demo video:
[![IMAGE ALT TEXT](https://i.ytimg.com/vi/IC44vvww9iE/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGGUgYShZMA8=&amp;rs=AOn4CLC3bJr9qua8GlCI4sJ5houVoVq_Sw)](https://www.youtube.com/watch?v=IC44vvww9iE)

A project for the course of Advanced Robotics in IPCA made in collaboration with:

[@joaopfaria30](https://github.com/joaopfaria30/)

[@helenacorreia](https://github.com/helenacorreia)



