# Call Manager

A simple single-screen mobile application that replicates WhatsApp's calling functionality.

## Features
The application includes the following clone features:

1. **Audio/Video Call Functionality**
2. **In-Call Controls**:
   - **Speaker/Phone** toggle
   - **Camera Switch** (Video Call)
   - **Mute/Unmute**
   - **Call End**
3. **Mock Incoming Call Kit**
4. **Work Manager Integration**:
   - Simulates an incoming call after 15 minutes.

## Steps to Run the App
1. Clone the repository.
2. Navigate to the project directory.
3. Run the application using the command:
   ```bash
   flutter run
   ```

## Application Use Cases
From the Home Page, you can perform the following actions:

### 1. Simulated Incoming Call
- Upon the first launch of the app, an incoming call is simulated after 10 seconds.
- Accepting the call navigates to the video call screen.
- Rejecting the call dismisses the simulation.

### 2. Predefined User List
- The Home Page contains a tile with a predefined list of users.
- Each user has options to initiate a call:
  - **Video Call**
  - **Audio Call**

### 3. Video Call Mode
- Switch between front and back cameras.
- Change the call mode from video to audio.
- Control the volume.
- End the call.

### 4. Audio Call Mode
- Switch from audio to video call mode.
- Control the volume.
- Mute/Unmute the microphone.
- End the call.

## Additional Notes
Simulated to video call is implemented only when app is active or background mode. 

