import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class appTheme extends ChangeNotifier {
  thisOption _currentTheme = thisOption(
    name: 'Blue Theme',
    description: 'Current default theme',
    primaryColor: const Color(0xFF4ECDC4),
    secondaryColor: const Color(0xFF44A08D),
    backgroundColor: const Color(0xFF2E5266),
  );

  thisOption get currentTheme => _currentTheme;

  Future<void> setThisTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeName = prefs.getString('stheme');
    
    if (savedThemeName != null) {
      final themes = [
        thisOption(
          name: 'Blue Theme',
          description: 'Chatting right now stop talking',
          primaryColor: const Color(0xFF4ECDC4),
          secondaryColor: const Color(0xFF44A08D),
          backgroundColor: const Color(0xFF2E5266),
        ),
        thisOption(
          name: 'Orange Theme',
          description: 'I need a hug bby gurl',
          primaryColor: const Color(0xFFFF6B35),
          secondaryColor: const Color(0xFFF7931E),
          backgroundColor: const Color(0xFF8B4513),
        ),
        thisOption(  
          name: 'Purple Theme',
          description: 'oh kitten dont be shy',
          primaryColor: const Color(0xFF9B59B6),
          secondaryColor: const Color(0xFF8E44AD),
          backgroundColor: const Color(0xFF4A235A),
        ),
        thisOption(
          name: 'Green Theme',
          description: 'Glorp',
          primaryColor: const Color(0xFF2ECC71),
          secondaryColor: const Color(0xFF27AE60),
          backgroundColor: const Color(0xFF145A32),
        ),
        thisOption(
          name: 'Dark Mode',
          description: 'Tuff',
          primaryColor: const Color(0xFF2C3E50),
          secondaryColor: const Color(0xFF34495E),
          backgroundColor: const Color(0xFF1B2631),
        ),
      ];
      
      final savedTheme = themes.firstWhere(
        (theme) => theme.name == savedThemeName,
        orElse: () => _currentTheme,
      );
      
      _currentTheme = savedTheme;
      notifyListeners();
    }
  }

  Future<void> changeTheme(thisOption newTheme) async {
    _currentTheme = newTheme;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('stheme', newTheme.name);
  }

  ThemeData get themeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _currentTheme.primaryColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: _currentTheme.backgroundColor,
    );
  }

  List<Color> get mainGradientColors => [
    _currentTheme.backgroundColor,
    _currentTheme.backgroundColor.withValues(alpha: 0.8),
    _currentTheme.backgroundColor.withValues(alpha: 0.6),
  ];

  List<Color> get navBarGradientColors => [
    _currentTheme.primaryColor,
    _currentTheme.secondaryColor,
  ];
  }

class thisOption {
  final String name;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;

  thisOption({
    required this.name,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
  });
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedTheme = 'Blue Theme';

  String _getThemeImagePath(String themeName) {
    String imagePath = '';
    switch (themeName) {
      case 'Blue Theme':
        imagePath = 'assets/images/blue.png';
        break;
      case 'Orange Theme':
        imagePath = 'assets/images/orange.png';
        break;
      case 'Purple Theme':
        imagePath = 'assets/images/purple.png';
        break;
      case 'Green Theme':
        imagePath = 'assets/images/green.png';
        break;
      case 'Dark Mode':
        imagePath = 'assets/images/dark.png';
        break;
      default:
        imagePath = 'assets/images/blue.png';
    }
    return imagePath;
}

  Widget _buildThemeIcon(String themeName, thisOption theme) {
    String imagePath = _getThemeImagePath(themeName);
    
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        imagePath,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.primaryColor, theme.secondaryColor],
              ),
            ),
            child: Icon(
              Icons.palette,
              color: Colors.white,
              size: 24,
            ),
          );
        },
        ),
    );
  }

  final List<thisOption> themes = [
    thisOption(
      name: 'Blue Theme',
      description: 'Chatting right now, LOL GOOD ONE ZOIL',
      primaryColor: const Color(0xFF4ECDC4),
      secondaryColor: const Color(0xFF44A08D),
      backgroundColor: const Color(0xFF2E5266),
  ),
    thisOption(
      name: 'Orange Theme',
      description: 'I need a hug bby gurl',
      primaryColor: const Color(0xFFFF6B35),
      secondaryColor: const Color(0xFFF7931E),
      backgroundColor: const Color(0xFF8B4513),
    ),
    thisOption(  
      name: 'Purple Theme',
      description: 'oh kitten, dont be shy',
      primaryColor: const Color(0xFF9B59B6),
      secondaryColor: const Color(0xFF8E44AD),
      backgroundColor: const Color(0xFF4A235A),
    ),
    thisOption(
      name: 'Green Theme',
      description: 'Glorp',
      primaryColor: const Color(0xFF2ECC71),
      secondaryColor: const Color(0xFF27AE60),
      backgroundColor: const Color(0xFF145A32),
    ),
    thisOption(
      name: 'Dark Mode',
      description: 'Tuff',
      primaryColor: const Color(0xFF2C3E50),
      secondaryColor: const Color(0xFF34495E),
      backgroundColor: const Color(0xFF1B2631),
    ),
];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<appTheme>(context);
    
    selectedTheme = themeProvider.currentTheme.name;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              themeProvider.currentTheme.backgroundColor,
              themeProvider.currentTheme.backgroundColor.withValues(alpha: 0.8),
              themeProvider.currentTheme.backgroundColor.withValues(alpha: 0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
               ), 
              
              const SizedBox(height: 20),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose Theme',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      Expanded(
                        child: ListView.builder(
                          itemCount: themes.length,
                          itemBuilder: (context, index) {
                            final theme = themes[index];
                            final isSelected = selectedTheme == theme.name;
                            
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? theme.primaryColor.withValues(alpha: 0.3)
                                    : Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected 
                                      ? theme.primaryColor 
                                      : Colors.white.withValues(alpha: 0.2),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                               child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    selectedTheme = theme.name;
                                  });
                                  
                                  await themeProvider.changeTheme(theme);
                                },
                                 child: Padding(
                                   padding: const EdgeInsets.all(20),
                                   child: Row(
                                     children: [
                                       _buildThemeIcon(theme.name, theme),
                                       const SizedBox(width: 20),
                                       Expanded(
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(
                                               theme.name,
                                               style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 18,
                                                 fontWeight: FontWeight.w600,
                                               ),
                                             ),
                                             const SizedBox(height: 4),
                                             Text(
                                               theme.description,
                                               style: TextStyle(
                                                 color: Colors.white.withOpacity(0.7),
                                                 fontSize: 14,
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       if (isSelected)
                                         Icon(
                                           Icons.check_circle,
                                           color: theme.primaryColor,
                                           size: 28,
                                         ),
                                     ],
                                   ),
                                 ),
                               ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                 ),
                ),
              
              const SizedBox(height: 40),
              
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: const Text(
                  'Glorp Entertainment Network',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2),
                      ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }
