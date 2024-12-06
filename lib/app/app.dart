import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:pokemon_time/app/bloc/screen_nav_cubit.dart';
import 'package:pokemon_time/app/screens/setting_screen.dart';
import 'package:pokemon_time/presentation/screens/pokemon_list_screen.dart';
import 'package:pokemon_time/presentation/widgets/pokemon_stack_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    List screens = const [
      PokemonListScreen(),
      CircleToSearchWithParticles(),
      SettingScreen(),
    ];
    return BlocBuilder<ScreenNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) =>
                {context.read<ScreenNavCubit>().onChangeScreen(value)},
            currentIndex: state,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.catching_pokemon),
                label: 'Pokémon',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SearchAnchor.bar(suggestionsBuilder: (context, index) {
//               return List.generate(10, (int index) {
//                 return PokemonStackWidget(pokemon: pokemon[index]);
//               });
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }

class CircleToSearchWithParticles extends StatefulWidget {
  const CircleToSearchWithParticles({super.key});

  @override
  State<CircleToSearchWithParticles> createState() =>
      _CircleToSearchWithParticlesState();
}

class _CircleToSearchWithParticlesState
    extends State<CircleToSearchWithParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radiusAnimation;

  // Random generator for particles
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _radiusAnimation = Tween<double>(begin: 0, end: 400).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  void _startAnimation() {
    _controller.forward(from: 0); // Reset animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circle to Search with Particles'),
      ),
      body: Stack(
        children: [
          // Background circle animation
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: CircleWithParticlesPainter(
              radius: _radiusAnimation.value,
              center: Offset(MediaQuery.of(context).size.width / 2, 300),
              random: _random,
            ),
          ),
          // Button to trigger animation
          Center(
            child: ElevatedButton(
              onPressed: _startAnimation,
              child: const Text('Start Search'),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleWithParticlesPainter extends CustomPainter {
  final double radius;
  final Offset center;
  final Random random;

  CircleWithParticlesPainter({
    required this.radius,
    required this.center,
    required this.random,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the expanding circle
    final circlePaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // Draw the expanding circle
    canvas.drawCircle(center, radius, circlePaint);

    // Paint for particles
    final particlePaint = Paint();

    // Generate particles
    for (int i = 0; i < 50; i++) {
      final angle = random.nextDouble() * 2 * pi; // Random angle
      final distance = random.nextDouble() * radius; // Random distance
      final particleX = center.dx + cos(angle) * distance;
      final particleY = center.dy + sin(angle) * distance;

      // Randomize color for particles
      particlePaint.color = _getRandomColor();

      // Randomize size of particles
      final particleSize = random.nextDouble() * 5 + 2;

      // Draw the particle
      canvas.drawCircle(
          Offset(particleX, particleY), particleSize, particlePaint);
    }
  }

  Color _getRandomColor() {
    // Randomly choose between red, blue, and white
    final colors = [Colors.red, Colors.blue, Colors.white];
    return colors[random.nextInt(colors.length)]
        .withOpacity(random.nextDouble() * 0.8 + 0.2); // Add shimmer effect
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
