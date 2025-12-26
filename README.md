# LG Voyager – Liquid Galaxy Controller

LG Voyager is a Flutter client for controlling a Liquid Galaxy (LG) rig over SSH. It focuses on quickly sending KML content, showing the LG logo, triggering relaunch operations, and visualizing an initial “fly to” camera position, all through a responsive, touch-friendly interface.

## Main Features

- **SSH-based LG control**  
  Connects to an LG master via SSH. Maintains connection state, credentials, rig count, and camera position in Riverpod providers. Runs an initial `flyTo` command on startup to position the LG view.

- **KML content management**  
  "Show KML 1" and "Show KML 2" actions push predefined KML experiences to the rig. "Clean KMLs" removes previously loaded KML content. KML helpers live under `lib/kml` and are orchestrated through `LGActions` and the `SSH` layer.

- **LG logo and relaunch tools**  
  "Show LG Logo" displays the Liquid Galaxy branding overlay. "Clean Logos" clears logo overlays. "Relaunch LG" opens a confirmation dialog and sends the relaunch command over SSH.

- **Responsive, animated UI**  
  `HomePage` uses `PortraitLayout` and `LandscapeLayout` to adapt controls for phones and tablets. A `CircularParticle` background and animated Earth widget provide visual feedback, with sizes tuned for small and large screens.

- **State management and modular controllers**  
  Riverpod providers manage SSH client, IP, credentials, rig configuration, and loading state. `LGActions` groups higher-level LG actions (KML operations, logo, relaunch), while `SSH` encapsulates low-level command execution.

## Architecture Overview

- **Framework**: Flutter (Dart), Material design, custom dark theme (`ThemesDark`).
- **State management**: `flutter_riverpod` for dependency injection and global state.
- **Networking / backend**: SSH control implemented in `lib/connection/ssh.dart` (likely using `dartssh2`).
- **UI composition**:
  - `lib/pages/HomePage.dart` – main control screen and layout selection.
  - `lib/pages/settings.dart` – connection and configuration screen.
  - `lib/widgets/portrait_layout.dart`, `lib/widgets/landscape_layout.dart` – orientation-specific layouts.
- **Domain-specific logic**:
  - `lib/controllers/lg_actions.dart` – high-level LG actions (KML, logo, relaunch, dialogs).
  - `lib/kml/*` – KML generation and helpers.
  - `lib/providers/connection_providers.dart` – connection, credential, and rig state providers.

This separation keeps LG-specific control logic (SSH and KML) isolated from presentation, simplifying extension with new actions or views.


## Basic Usage

1. **Configure connection**  
   - Launch the app.  
   - Tap the settings icon (gear) in the `AppBar` to open the connection screen.  
   - Enter LG master IP, SSH port, username, password or key, and rig count.  
   - Save or apply the configuration to establish the SSH connection.

2. **Initial behavior**  
   On startup, `HomePage` sends an initial `flyTo` command (for example, to a default coordinate) using the `SSH` layer and initializes the connection.

3. **Control KML content**  
   - Use **Show KML 1** to push the first predefined KML.  
   - Use **Show KML 2** for the second scenario.  
   - Use **Clean KMLs** to remove currently loaded KML layers.

4. **Logo and relaunch actions**  
   - Tap **Show LG Logo** to display the LG logo overlay.  
   - Tap **Clean Logos** to clear logo overlays.  
   - Tap **Relaunch LG** and confirm to trigger a relaunch of the LG system via SSH.
