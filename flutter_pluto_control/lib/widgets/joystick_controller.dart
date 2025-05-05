
import 'package:flutter/material.dart';
import 'package:flutter_pluto_control/services/esp_service.dart';
import 'package:flutter_pluto_control/widgets/icon_button.dart';

class JoystickController extends StatelessWidget {
  final Function(Command) onDirectionPress;
  final Command? activeCommand;

  const JoystickController({
    super.key,
    required this.onDirectionPress,
    this.activeCommand,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: GridView.count(
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Empty top-left corner
          Container(),
          
          // Top button (FRONT)
          NeonIconButton(
            icon: Icons.arrow_upward,
            tooltip: 'Forward',
            onPressed: () => onDirectionPress(Command.FRONT),
            active: activeCommand == Command.FRONT,
          ),
          
          // Empty top-right corner
          Container(),
          
          // Left button
          NeonIconButton(
            icon: Icons.arrow_back,
            tooltip: 'Left',
            onPressed: () => onDirectionPress(Command.LEFT),
            active: activeCommand == Command.LEFT,
          ),
          
          // Center "joystick" button
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF33E8F0).withOpacity(0.2),
              border: Border.all(
                color: const Color(0xFF33E8F0),
                width: 2,
              ),
            ),
            child: Center(
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF33E8F0),
                ),
              ),
            ),
          ),
          
          // Right button
          NeonIconButton(
            icon: Icons.arrow_forward,
            tooltip: 'Right',
            onPressed: () => onDirectionPress(Command.RIGHT),
            active: activeCommand == Command.RIGHT,
          ),
          
          // Empty bottom-left corner
          Container(),
          
          // Down button
          NeonIconButton(
            icon: Icons.arrow_downward,
            tooltip: 'Down',
            onPressed: () => onDirectionPress(Command.DOWN),
            active: activeCommand == Command.DOWN,
          ),
          
          // Empty bottom-right corner
          Container(),
        ],
      ),
    );
  }
}
