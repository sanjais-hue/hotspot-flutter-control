
import 'package:flutter/material.dart';
import 'package:flutter_pluto_control/services/esp_service.dart';
import 'package:flutter_pluto_control/widgets/control_button.dart';
import 'package:flutter_pluto_control/widgets/icon_button.dart';
import 'package:flutter_pluto_control/widgets/joystick_controller.dart';
import 'package:flutter_pluto_control/widgets/connect_dialog.dart';
import 'package:flutter_pluto_control/widgets/status_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Command? activeCommand;

  @override
  Widget build(BuildContext context) {
    final espService = Provider.of<EspConnectionService>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.1, 0.2),
            radius: 0.8,
            colors: [
              const Color(0xFF3C0AA0).withOpacity(0.2),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            stops: const [0.0, 0.7],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PLUTO',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF33E8F0),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StatusIndicator(
                          connected: espService.connected,
                          command: espService.lastCommand?.toString().split('.').last ?? 'IDLE',
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (espService.connected) {
                              espService.disconnect();
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => ConnectDialog(
                                  initialIp: espService.ipAddress,
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.wifi,
                            size: 16,
                            color: espService.connected 
                                ? const Color(0xFFFF5555) 
                                : const Color(0xFF33E8F0),
                          ),
                          label: Text(
                            espService.connected ? 'Disconnect' : 'Connect',
                            style: TextStyle(
                              color: espService.connected 
                                  ? const Color(0xFFFF5555) 
                                  : const Color(0xFF33E8F0),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide(
                              color: espService.connected 
                                  ? const Color(0xFFFF5555) 
                                  : const Color(0xFF33E8F0),
                              width: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Main Controls
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left column - Direction Controls
                            Expanded(
                              child: Column(
                                children: [
                                  // Joystick Controller
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A1F2C).withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFF33E8F0).withOpacity(0.3),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Movement Controls',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF33E8F0),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        JoystickController(
                                          onDirectionPress: (command) {
                                            setState(() {
                                              activeCommand = command;
                                            });
                                            espService.sendCommand(command);
                                            Future.delayed(
                                              const Duration(milliseconds: 300),
                                              () {
                                                if (mounted) {
                                                  setState(() {
                                                    activeCommand = null;
                                                  });
                                                }
                                              },
                                            );
                                          },
                                          activeCommand: activeCommand,
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  
                                  // Dance Modes
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A1F2C).withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFF33E8F0).withOpacity(0.3),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Dance Modes',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF33E8F0),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ControlButton(
                                                label: 'DANCE 1',
                                                onPressed: () {
                                                  setState(() {
                                                    activeCommand = Command.DANCE1;
                                                  });
                                                  espService.sendCommand(Command.DANCE1);
                                                  Future.delayed(
                                                    const Duration(milliseconds: 300),
                                                    () {
                                                      if (mounted) {
                                                        setState(() {
                                                          activeCommand = null;
                                                        });
                                                      }
                                                    },
                                                  );
                                                },
                                                active: activeCommand == Command.DANCE1,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: ControlButton(
                                                label: 'DANCE 2',
                                                onPressed: () {
                                                  setState(() {
                                                    activeCommand = Command.DANCE2;
                                                  });
                                                  espService.sendCommand(Command.DANCE2);
                                                  Future.delayed(
                                                    const Duration(milliseconds: 300),
                                                    () {
                                                      if (mounted) {
                                                        setState(() {
                                                          activeCommand = null;
                                                        });
                                                      }
                                                    },
                                                  );
                                                },
                                                active: activeCommand == Command.DANCE2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(width: 16),
                            
                            // Right column - Action Controls
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1A1F2C).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF33E8F0).withOpacity(0.3),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Action Controls',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF33E8F0),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    GridView.count(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        NeonIconButton(
                                          icon: Icons.access_time,
                                          tooltip: 'Clock',
                                          onPressed: () {
                                            setState(() {
                                              activeCommand = Command.CLOCK;
                                            });
                                            espService.sendCommand(Command.CLOCK);
                                            Future.delayed(
                                              const Duration(milliseconds: 300),
                                              () {
                                                if (mounted) {
                                                  setState(() {
                                                    activeCommand = null;
                                                  });
                                                }
                                              },
                                            );
                                          },
                                          active: activeCommand == Command.CLOCK,
                                        ),
                                        NeonIconButton(
                                          icon: Icons.bug_report,
                                          tooltip: 'Bug',
                                          onPressed: () {
                                            setState(() {
                                              activeCommand = Command.BUG;
                                            });
                                            espService.sendCommand(Command.BUG);
                                            Future.delayed(
                                              const Duration(milliseconds: 300),
                                              () {
                                                if (mounted) {
                                                  setState(() {
                                                    activeCommand = null;
                                                  });
                                                }
                                              },
                                            );
                                          },
                                          active: activeCommand == Command.BUG,
                                        ),
                                        NeonIconButton(
                                          icon: Icons.nightlight_round,
                                          tooltip: 'Moon',
                                          onPressed: () {
                                            setState(() {
                                              activeCommand = Command.MOON;
                                            });
                                            espService.sendCommand(Command.MOON);
                                            Future.delayed(
                                              const Duration(milliseconds: 300),
                                              () {
                                                if (mounted) {
                                                  setState(() {
                                                    activeCommand = null;
                                                  });
                                                }
                                              },
                                            );
                                          },
                                          active: activeCommand == Command.MOON,
                                        ),
                                        NeonIconButton(
                                          icon: Icons.back_hand,
                                          tooltip: 'Hand',
                                          onPressed: () {
                                            setState(() {
                                              activeCommand = Command.HAND;
                                            });
                                            espService.sendCommand(Command.HAND);
                                            Future.delayed(
                                              const Duration(milliseconds: 300),
                                              () {
                                                if (mounted) {
                                                  setState(() {
                                                    activeCommand = null;
                                                  });
                                                }
                                              },
                                            );
                                          },
                                          active: activeCommand == Command.HAND,
                                        ),
                                        NeonIconButton(
                                          icon: Icons.fitness_center,
                                          tooltip: 'Dumbbell',
                                          onPressed: () {
                                            setState(() {
                                              activeCommand = Command.DUMBBELL;
                                            });
                                            espService.sendCommand(Command.DUMBBELL);
                                            Future.delayed(
                                              const Duration(milliseconds: 300),
                                              () {
                                                if (mounted) {
                                                  setState(() {
                                                    activeCommand = null;
                                                  });
                                                }
                                              },
                                            );
                                          },
                                          active: activeCommand == Command.DUMBBELL,
                                        ),
                                        NeonIconButton(
                                          icon: Icons.sentiment_satisfied_alt,
                                          tooltip: 'Smile',
                                          onPressed: () {
                                            setState(() {
                                              activeCommand = Command.SMILE;
                                            });
                                            espService.sendCommand(Command.SMILE);
                                            Future.delayed(
                                              const Duration(milliseconds: 300),
                                              () {
                                                if (mounted) {
                                                  setState(() {
                                                    activeCommand = null;
                                                  });
                                                }
                                              },
                                            );
                                          },
                                          active: activeCommand == Command.SMILE,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Progress Bar (purely aesthetic)
                        Container(
                          height: 4,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1F2C),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: const Color(0xFF33E8F0).withOpacity(0.3),
                            ),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.75,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF33E8F0).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
