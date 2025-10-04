import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/injection.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../core/constants/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _backgroundController;
  late final AnimationController _particleController;
  
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoRotation;
  late final Animation<double> _backgroundOpacity;
  late final Animation<double> _particleAnimation;
  
  Timer? _timer;
  List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    
    // Initialize particles
    _initializeParticles();
    
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _logoScale = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));
    
    _logoFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    ));
    
    _logoRotation = Tween<double>(
      begin: -0.2,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));
    
    // Background gradient animation
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _backgroundOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));
    
    // Particle animation
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    
    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations
    _logoController.forward();
    _backgroundController.forward();
    _particleController.repeat();

    // Preload and navigate
    _timer = Timer(const Duration(milliseconds: 2500), () async {
      if (!mounted) return;
      
      try {
        await precacheImage(const AssetImage('assets/ic_logo.png',), context);
      } catch (_) {}
      
      if (!mounted) return;
      
      // Prefetch initial data
      try {
        final repo = getIt<MovieRepository>();
        await Future.wait([
          repo.refreshTrending(),
          repo.refreshNowPlaying(),
        ]);
      } catch (_) {}
      
      if (!mounted) return;
      context.go('/');
    });
  }

  void _initializeParticles() {
    final random = math.Random();
    _particles = List.generate(20, (index) {
      return Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 4 + 2,
        speed: random.nextDouble() * 0.5 + 0.1,
        opacity: random.nextDouble() * 0.5 + 0.3,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _logoController.dispose();
    _backgroundController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _logoController,
          _backgroundController,
          _particleController,
        ]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(_backgroundOpacity.value),
                  AppColors.primaryLight.withOpacity(_backgroundOpacity.value * 0.8),
                  AppColors.accent.withOpacity(_backgroundOpacity.value * 0.6),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated background particles
                ..._particles.map((particle) => _buildParticle(particle)),
                
                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with animations
                      Transform.scale(
                        scale: _logoScale.value,
                        child: Transform.rotate(
                          angle: _logoRotation.value,
                          child: Opacity(
                            opacity: _logoFade.value,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'assets/ic_logo.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // App name with fade animation
                      Opacity(
                        opacity: _logoFade.value,
                        child: Text(
                          'Movie Verse',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                            letterSpacing: 2,
                            shadows: [
                              const Shadow(
                                blurRadius: 10,
                                color: Colors.black26,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Subtitle with delay
                      Opacity(
                        opacity: _logoFade.value * 0.8,
                        child: Text(
                          'Discover Amazing Movies',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 60),
                      
                      // Loading indicator
                      Opacity(
                        opacity: _logoFade.value,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildParticle(Particle particle) {
    final progress = _particleAnimation.value;
    final animatedY = (particle.y + progress * particle.speed) % 1.0;
    
    return Positioned(
      left: particle.x * MediaQuery.of(context).size.width,
      top: animatedY * MediaQuery.of(context).size.height,
      child: Opacity(
        opacity: particle.opacity * (1 - progress),
        child: Container(
          width: particle.size,
          height: particle.size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(particle.size / 2),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                blurRadius: particle.size,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}


