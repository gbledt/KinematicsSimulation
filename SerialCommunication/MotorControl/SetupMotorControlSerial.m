function [serialMotorControl, motor] = ...
    SetupMotorControlSerial(motorControlCOM)
%% ======================Setup Motor Control Serial========================
% RoboHAZMAT: Senior Design Project
% Motion Control Team
% Gerardo Bledt
% December 29, 2014
%
% Sets up the communication with the Arduino motor controller and joint
% servos for the Mechatronic Arm over Serial.

% Check if COM port is available
if (~ismember(GetAvailableCOM,motorControlCOM))
    error('%s is not available',motorControlCOM);
end

% Open communication with the Arduino
serialMotorControl = arduino(motorControlCOM);

% Define motor PWM pins
motor = struct();
motor.neckYaw = 6;
motor.neckPitch = 5;
motor.neckRoll = 3;
motor.gripperRight = 9;
motor.gripperLeft = 10;

% Attach servo motors to their pins
serialMotorControl.servoAttach(motor.neckYaw);
serialMotorControl.servoAttach(motor.neckPitch);
serialMotorControl.servoAttach(motor.neckRoll);
serialMotorControl.servoAttach(motor.gripperRight);
serialMotorControl.servoAttach(motor.gripperLeft);

RobotHeadControl(serialMotorControl, motor, zeros(3,1));
RobotGripperControl(serialMotorControl, motor, zeros(2,1));