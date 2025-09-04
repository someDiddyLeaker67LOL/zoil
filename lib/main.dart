import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'Themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = appTheme();
  await themeProvider.setThisTheme();
  runApp(ZoilLOL(themeProvider: themeProvider));
}

class TwitchLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const TwitchLogo({
    super.key,
    this.size = 30,
    this.color,
  });

  @override 
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final Uri twitchUrl = Uri.parse('https://twitch.tv/zoil');
          
          final bool launched = await launchUrl(
            twitchUrl,
            mode: LaunchMode.externalApplication,
          );
          
          if (!launched) {
            await launchUrl(
              twitchUrl,
              mode: LaunchMode.platformDefault,
            );
          }
        } catch (e) {
          // error
        }
      },
      child: Image.asset(
        'assets/images/twitch.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: Colors.transparent,
          );
        },
      ),
    );
  }
}

class ZoilLOL extends StatelessWidget {
  final appTheme themeProvider;
  
  const ZoilLOL({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: themeProvider,
      child: Consumer<appTheme>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Zoil a diddy blud !',
            theme: themeProvider.themeData,
            home: const SoundboardPage(),

          );
        },
      ),
       );
    }
}

class SoundboardPage extends StatefulWidget {
  const SoundboardPage({super.key});

  @override
  State<SoundboardPage> createState() => _SoundboardPageState();
}

class _SoundboardPageState extends State<SoundboardPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool lilFunnyThing = false;
  bool arrangeMode = false;
  bool ayoooooWhoMadeThis = false;

  @override
  void initState() {
    super.initState();
    _loadCustomLayout();
    _loadWatermark();
  }
// main button styles 
// if changing names here make sure they match with the case switch statments below this 
  final List<SoundButton> soundButtons = [
    SoundButton(
      text: '67', 
      textColors: [Colors.red, Colors.blue], 
      backgroundColor: Colors.blue.shade900,
      audioFile: '67.mp3'
    ),
    SoundButton(
      text: 'AWOOOOO', 
      textColors: [Colors.red], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'AWOOOOO.mp3'
    ),
    SoundButton(
      text: 'Be a Good Girl', 
      textColors: [const Color.fromARGB(255, 10, 252, 18)], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'BeAGOODgirl.mp3'
    ),
    SoundButton(
      text: 'FEET', 
      textColors: [Colors.orange], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'FEET.mp3'
    ),
    SoundButton(
      text: 'W FAPS', 
      textColors: [const Color.fromARGB(255, 226, 10, 161)], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'WW.mp3'
    ),
    SoundButton(
      text: 'Naughty Cat', 
      textColors: [Colors.yellow], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'Nautycat.mp3'
    ),
    SoundButton(
      text: 'OOOOOOOOO', 
      textColors: [Colors.red], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'OOOOOOOOO.mp3'
    ),
    SoundButton(
      text: 'Purrrrrrrr', 
      textColors: [Colors.lightBlue, Colors.green], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'purrrrrrrr.mp3'
    ),
    SoundButton(
      text: 'RAWR RAWR\nxD', 
      textColors: [Colors.green], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'rawr.mp3'
    ),
    SoundButton(
      text: 'Tuff', 
      textColors: [Colors.red], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'Tuff.mp3'
    ),
    SoundButton(
      text: 'Yes papi!', 
      textColors: [Colors.orange], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'YESpapi.mp3'
    ),
    SoundButton(
      text: 'LOL', 
      textColors: [Colors.yellow, Colors.grey], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'lel.mp3'
    ),
    SoundButton(
      text: 'MUSTAAAAAARRD', 
      textColors: [Colors.purple], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'MUSTAAAAAARRD.mp3'
    ),
    SoundButton(
      text: 'Yif Yif!', 
      textColors: [Colors.cyan, Colors.pink], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'YiffYiff.mp3'
    ),
    SoundButton(
      text: 'Nya itchy knee san', 
      textColors: [Colors.orange, Colors.blue], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'arigato.mp3'
    ),
    SoundButton(
      text: 'Oh myy gawwwd', 
      textColors: [Colors.yellow], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'omgBruh.mp3'
    ),
    SoundButton(
      text: 'LOOOOOOL', 
      textColors: [Colors.green, Colors.red], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'LOL.mp3'
    ),
    SoundButton(
      text: 'U good mud?', 
      textColors: [Colors.purple, Colors.cyan], 
      backgroundColor: Colors.blue.shade900, 
      audioFile: 'mud.mp3'
    ),
    SoundButton(
      text: 'A A A A A A', 
      textColors: [Colors.pink, Colors.orange], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'AaAaAaA.mp3'
    ),
    SoundButton(
      text: '?', 
      textColors: [Colors.blue, Colors.yellow], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'age.mp3'
    ),
    SoundButton(
      text: 'Nmaberamiai', 
      textColors: [Colors.red, Colors.green], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'googoo.mp3'
    ),
    SoundButton(
      text: 'NAHHHH', 
      textColors: [Colors.cyan, Colors.purple], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'NAHH.mp3'
    ),
    SoundButton(
      text: 'GOATED\nFAPS', 
      textColors: [Colors.orange, Colors.pink], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'GOATED.mp3'
    ),
    SoundButton(
      text: 'MOO MOO', 
      textColors: [Colors.yellow, Colors.blue], 
      backgroundColor: Colors.blue.shade900,
      audioFile: 'MOOO.mp3'
    ),
];

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playSound(String audioFile) async {
    try {
      if (isPlaying) {
        await audioPlayer.stop();
      }

 // easter egg audio file
    setState(() {
          isPlaying = true;
          lilFunnyThing = audioFile == 'EasterEgg.mp3';
        });
      
      await audioPlayer.play(AssetSource('audio/$audioFile'));
      
      await audioPlayer.onPlayerComplete.first;
      
      setState(() {
        isPlaying = false;
        lilFunnyThing = false; 
      });
    } catch (e) {
      setState(() {
        isPlaying = false;
        lilFunnyThing = false;
      });
    }
  }

  void _toggleArrangeMode() async {
    if (arrangeMode) {
      await _saveCustomLayout();
    }
    setState(() {
      arrangeMode = !arrangeMode;
    });
  }

  Future<void> _saveCustomLayout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> audioFiles = soundButtons.map((btn) => btn.audioFile).toList();
      await prefs.setString('store_arrangment', jsonEncode(audioFiles));
    } catch (e) {
      // error
    }
  }

  Future<void> _loadCustomLayout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final customLayout = prefs.getString('store_arrangment');
      
      if (customLayout != null) {
        final List<dynamic> layoutData = jsonDecode(customLayout);
        final List<String> customOrder = layoutData.cast<String>();
        
        final List<SoundButton> newOrder = [];
        for (String audioFile in customOrder) {
          try {
            final button = soundButtons.firstWhere(
              (btn) => btn.audioFile == audioFile,
            );
            newOrder.add(button);
          } catch (e) {
            // invalid button
          }
        }
        
        for (SoundButton button in soundButtons) {
          if (!newOrder.contains(button)) {
            newOrder.add(button);
          }
        }
        
        setState(() {
          soundButtons.clear();
          soundButtons.addAll(newOrder);
        });
      }
    } catch (e) {
      // error 
    }
  }

  Future<void> _loadWatermark() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final creatorState = prefs.getBool('realWatermark');
      if (creatorState != null) {
        setState(() {
          ayoooooWhoMadeThis = creatorState;
        });
      }
    } catch (e) {
      // error
    }
  }

  Future<void> _saveWatermark() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('realWatermark', ayoooooWhoMadeThis);
    } catch (e) {
      // error
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<appTheme>(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: themeProvider.mainGradientColors,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: CustomPaint(
                  painter: CarbonFiberPainter(themeColor: themeProvider.currentTheme.primaryColor),
                ),
              ),
            ),
            
            SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'The Zoil',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0,
                                shadows: [
                                  Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
                                ],
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              'Soundboard',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 2.0,
                                shadows: [
                                  Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                setState(() {
                                  ayoooooWhoMadeThis = !ayoooooWhoMadeThis;
                                });
                                _saveWatermark();
                              },
                              child: Text(
                                ayoooooWhoMadeThis ? 'Made By DesktopSetup' : 'Glorp Entertainment Network',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.5,
                                  fontStyle: FontStyle.italic,
                                  shadows: [
                                    Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // soundboard buttons and container
                  
                  const SizedBox(height: 32),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  color: themeProvider.currentTheme.primaryColor.withValues(alpha:0.25),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 15,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                clipBehavior: Clip.none,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(40, 24, 40, 24),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        child: ClipRect(
                                          clipBehavior: Clip.hardEdge,
                                          child: arrangeMode
                                              ? ReorderableListView.builder(
                                                  clipBehavior: Clip.none,
                                                  physics: const BouncingScrollPhysics(),
                                                  itemCount: soundButtons.length, 
                                                  buildDefaultDragHandles: true,
                                                  proxyDecorator: (Widget child, int index, Animation<double> animation) {
                                                    return AnimatedBuilder(
                                                      animation: animation,
                                                      builder: (BuildContext context, Widget? child) {
                                                        return Opacity(
                                                          opacity: 0.8,
                                                          child: child,
                                                        );
                                                      },
                                                      child: child,
                                                    );
                                                  },
                                                  onReorder: (oldIndex, newIndex) {
                                                    setState(() {
                                                      if (oldIndex < newIndex) {
                                                        newIndex -= 1;
                                                      }
                                                      final item = soundButtons.removeAt(oldIndex);
                                                      soundButtons.insert(newIndex, item);
                                                    });
                                                  },
                                                  itemBuilder: (context, rowIndex) {
                                                    return Container(
                                                      key: ValueKey('row_$rowIndex'),
                                                      height: 50,
                                                      margin: const EdgeInsets.only(bottom: 14),
                                                      child: rowIndex < soundButtons.length
                                                      ? SoundboardButton(
                                                               button: soundButtons[rowIndex],
                                                               onPressed: () => playSound(soundButtons[rowIndex].audioFile),
                                                             )
                                                          : const SizedBox.shrink(),
                                                    );
                                                  },
                                                )
                                              : ListView.builder(
                                                  clipBehavior: Clip.none,
                                                  physics: const BouncingScrollPhysics(),
                                                  itemCount: (soundButtons.length / 2).ceil(),
                                                  itemBuilder: (context, rowIndex) {
                                                    final startIndex = rowIndex * 2;
                                                    
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 50, 
                                                            margin: const EdgeInsets.only(bottom: 14, right: 5),
                                                            child: startIndex < soundButtons.length
                                                                 ? SoundboardButton(
                                                                     button: soundButtons[startIndex],
                                                                     onPressed: () => playSound(soundButtons[startIndex].audioFile),
                                                                   )
                                                                : const SizedBox.shrink(),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            height: 50,
                                                            margin: const EdgeInsets.only(bottom: 14, left: 5),
                                                            child: startIndex + 1 < soundButtons.length
                                                                 ? SoundboardButton(
                                                                     button: soundButtons[startIndex + 1],
                                                                     onPressed: () => playSound(soundButtons[startIndex + 1].audioFile),
                                                                   )
                                                                : const SizedBox.shrink(),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                        ),
                                      ),
                                      const SizedBox(height: 50),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Positioned(
                          bottom: 76, 
                          left: 40, 
                          right: 40,
                          child: Container(
                            height: 3.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // nav bar icons and spacing

                  const Spacer(),
                  
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: themeProvider.navBarGradientColors,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 17),
                          
                           Row(
                             children: [
                               const TwitchLogo(size: 30, color: Colors.white),
                               const SizedBox(width: 14),
                               
                               IconButton(
                                 icon: const Icon(Icons.settings, color: Colors.white, size: 30),
                                 onPressed: () {
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => const SettingsPage(),
                                     ),
                                   );
                                 },
                               ),
                               const SizedBox(width: 17),
                             ],
                           ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Positioned(
              top: 50,
              left: 24,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: Icon(
                    arrangeMode ? Icons.check : Icons.drag_indicator,
                    color: arrangeMode ? Colors.green : Colors.white,
                    size: 30,
                  ),
                  onPressed: _toggleArrangeMode,
                ),
              ),
            ),
            
            // zoils FAT ass model
            Positioned(
              bottom: 0, 
              left: 0, 
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final screenHeight = MediaQuery.of(context).size.height;
                  
                  final baseWidth = 500.0;
                  final baseHeight = 467.0;
                  
                  final minWidthScale = (screenWidth / 350.0).clamp(1.0, 4.0);
                  
                  final safeAreaTop = MediaQuery.of(context).padding.top;
                  
                  final headerHeight = 120.0;
                  final spacingforButtons = 32.0;
                  final containerHeight = 300.0;
                  final lineOffset = 76.0;
                  
                  final yellowLineFromTop = safeAreaTop + headerHeight + spacingforButtons + containerHeight - lineOffset;
                  
                  final availableHeightForImage = screenHeight - yellowLineFromTop;
                  
                  final lineCollision = (availableHeightForImage / baseHeight).clamp(0.5, 4.0);
                  
                  final baseLeft = -baseWidth * 0.15;
                  final rightEdge = baseLeft + baseWidth; 
                  final maxWidth = (screenWidth / (rightEdge.abs())).clamp(0.8, 4.0);
                  
                  final finalScale = [minWidthScale, lineCollision, maxWidth].reduce((a, b) => a < b ? a : b);
                  
                  final finalWidth = baseWidth * finalScale;
                  final finalHeight = baseHeight * finalScale;
                  
                  final leftPosition = -finalWidth * 0.15;
                  
                  return Transform.translate(
                    offset: Offset(leftPosition, 0),
                    child: Container(
                      width: finalWidth,
                      height: finalHeight,
                      child: TransparentImage(
                        imagePath: lilFunnyThing ? 'assets/images/om2.png' : 'assets/images/om1.png',
                        width: finalWidth,
                        height: finalHeight,
                        fit: BoxFit.contain,
                        onSecretTap: () => playSound('EasterEgg.mp3'),
                        lilFunnyThing: lilFunnyThing,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SoundButton {
  final String text;
  final List<Color> textColors;
  final Color backgroundColor;
  final String audioFile;

  SoundButton({
    required this.text,
    required this.textColors,
    required this.backgroundColor,
    required this.audioFile,
  });
}

class SoundboardButton extends StatefulWidget {
  final SoundButton button;
  final VoidCallback onPressed;

  const SoundboardButton({
    super.key,
    required this.button,
    required this.onPressed,
  });

  @override
  State<SoundboardButton> createState() => _SoundboardButtonState();
}

class _SoundboardButtonState extends State<SoundboardButton> {

// TextStyle is set to const and will lose font style if not same name as SoundButton function above 

  TextStyle _getUniqueTextStyle() {
    switch (widget.button.text) {
      case '67':
        return const TextStyle(
          fontFamily: 'BlackOpsOne',
          color: Colors.white,
          fontSize: 29,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'AWOOOOO':
        return const TextStyle(
          fontFamily: 'ChangaOne',
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'Be a Good Girl':
        return const TextStyle(
          fontFamily: 'FredokaOne',
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'FEET':
        return const TextStyle(
          fontFamily: 'Audiowide',
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'W FAPS':
        return const TextStyle(
          fontFamily: 'Bangers',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'Naughty Cat':
        return const TextStyle(
          fontFamily: 'Orbitron',
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'OOOOOOOOO':
        return const TextStyle(
          fontFamily: 'RussoOne',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'Purrrrrrrr':
        return const TextStyle(
          fontFamily: 'Righteous',
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'RAWR RAWR\nxD':
        return const TextStyle(
          fontFamily: 'LondrinaSolid',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'Tuff':
        return const TextStyle(
          fontFamily: 'PermanentMarker',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'Yes papi!':
        return const TextStyle(
          fontFamily: 'PressStart2P',
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'LOL':
        return const TextStyle(
          fontFamily: 'Creepster',
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'MUSTAAAAAARRD':
        return const TextStyle(
          fontFamily: 'Creepster',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'Yif Yif!':
        return const TextStyle(
          fontFamily: 'BlackOpsOne',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'Nya itchy knee san':
        return const TextStyle(
          fontFamily: 'FredokaOne',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'Oh myy gawwwd':
        return const TextStyle(
          fontFamily: 'PermanentMarker',
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'LOOOOOOL':
        return const TextStyle(
          fontFamily: 'Bangers',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'U good mud?':
        return const TextStyle(
          fontFamily: 'PressStart2P',
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 2.0,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'A A A A A A':
        return const TextStyle(
          fontFamily: 'RussoOne',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case '?':
        return const TextStyle(
          fontFamily: 'Righteous',
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          height: 1.1,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'Nmaberamiai':
        return const TextStyle(
          fontFamily: 'ChangaOne',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'NAHHHH':
        return const TextStyle(
          fontFamily: 'LondrinaSolid',
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          height: 1.1,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'GOATED\nFAPS':
        return const TextStyle(
          fontFamily: 'Audiowide',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          height: 1.1,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'MOO MOO':
        return const TextStyle(
          fontFamily: 'Orbitron',
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          letterSpacing: 2.0,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'BABATUNDE':
        return const TextStyle(
          fontFamily: 'BlackOpsOne',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'FAMILY\nGUY':
        return const TextStyle(
          fontFamily: 'FredokaOne',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          height: 1.1,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'BABATUNDE\nFAMILY':
        return const TextStyle(
          fontFamily: 'ChangaOne',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          height: 1.1,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'FAMILY\nGUY!':
        return const TextStyle(
          fontFamily: 'Bangers',
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          height: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      case 'BABATUNDE\nFAMILY GUY':
        return const TextStyle(
          fontFamily: 'Audiowide',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          height: 1.1,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
      
      default:
        return const TextStyle(
          fontFamily: 'HandDrawn',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          shadows: [
            const Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<appTheme>(
      builder: (context, themeProvider, child) {
        return GestureDetector(
          onTap: () {
            widget.onPressed();
            HapticFeedback.lightImpact();
          },
            child: Container(
             decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  themeProvider.currentTheme.primaryColor.withValues(alpha: 0.8),
                  themeProvider.currentTheme.primaryColor,
                  themeProvider.currentTheme.secondaryColor,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 1.2,
              ),
            ),
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) {
                  if (widget.button.textColors.length > 1) {
                    return LinearGradient(
                      colors: widget.button.textColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  } else {
                    return LinearGradient(
                      colors: [widget.button.textColors.first, widget.button.textColors.first],
                    ).createShader(bounds);
                  }
                },
                child: Text(
                  widget.button.text,
                  style: _getUniqueTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
       },
    );
  }
}

class CarbonFiberPainter extends CustomPainter {
  final Color themeColor;
  
  CarbonFiberPainter({required this.themeColor});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = themeColor.withValues(alpha:0.35)
      ..strokeWidth = 2.0;

    final double stepSize = 40.0;
    final double stairWidth = stepSize * 2;
    
    for (double y = 0; y < size.height; y += stepSize) {
      for (double x = 0; x < size.width; x += stairWidth) {
        canvas.drawLine(
          Offset(x, y),
          Offset(x + stepSize, y),
          paint,
        );
        
        canvas.drawLine(
          Offset(x + stepSize, y),
          Offset(x + stepSize, y + stepSize),
          paint,
        );
        
        canvas.drawLine(
          Offset(x + stepSize, y + stepSize),
          Offset(x + stairWidth, y + stepSize),
          paint,
        );
      }
     }
    
    final accentPaint = Paint()
      ..color = themeColor.withValues(alpha:0.15)
      ..strokeWidth = 1.5;
    
    for (double i = 0; i < size.width + size.height; i += stepSize * 3) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i - size.height, size.height),
        accentPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TransparentImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final VoidCallback? onSecretTap;
  final bool lilFunnyThing;

  const TransparentImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit,
    this.onSecretTap,
    this.lilFunnyThing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: Image.asset(
              imagePath,
              key: ValueKey(imagePath),
              width: width,
              height: height,
              fit: fit,
            ),
          ),
         ),

        // easteregg on zoils thang but not always and i dont really care
        if (onSecretTap != null)
          Positioned.fill(
            child: Align(
              alignment: Alignment(-0.16, 0.64),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  onSecretTap!();
                  HapticFeedback.lightImpact();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
      ],
      );
   }
 }
