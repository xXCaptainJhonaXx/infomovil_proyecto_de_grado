import 'package:flutter/material.dart';

// Importamos cada una de las pestañas independientes creadas
import 'package:infocal_infomovil/view/tabs/principal_tab.dart';
import 'package:infocal_infomovil/view/tabs/horario_tab.dart';
import 'package:infocal_infomovil/view/tabs/calificaciones_tab.dart';
import 'package:infocal_infomovil/view/tabs/cuotas_tab.dart';
import 'package:infocal_infomovil/view/tabs/perfil_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos las llaves de navegación independientes para cada pestaña.
    // Esto es lo que permite que cada sección mantenga su propio historial (su propio "back").
    final tab1Key = GlobalKey<NavigatorState>();
    final tab2Key = GlobalKey<NavigatorState>();
    final tab3Key = GlobalKey<NavigatorState>();
    final tab4Key = GlobalKey<NavigatorState>();
    final tab5Key = GlobalKey<NavigatorState>();

    return PersistentBottomBarScaffold(
      items: [
        PersistentTabItem(
          tab: const PrincipalTab(),
          icon: Icons.home_rounded,
          title: 'Inicio',
          navigatorkey: tab1Key,
        ),
        PersistentTabItem(
          tab: const HorarioTab(),
          icon: Icons.calendar_month_rounded,
          title: 'Horarios',
          navigatorkey: tab2Key,
        ),
        PersistentTabItem(
          tab: const CalificacionesTab(),
          icon: Icons.assignment_rounded,
          title: 'Calificaciones',
          navigatorkey: tab3Key,
        ),
        PersistentTabItem(
          tab: const CuotasTab(),
          icon: Icons.payments_rounded,
          title: 'Cuotas',
          navigatorkey: tab4Key,
        ),
        PersistentTabItem(
          tab: const PerfilTab(),
          icon: Icons.person_rounded,
          title: 'Perfil',
          navigatorkey: tab5Key,
        ),
      ],
    );
  }
}

// =========================================================================
// COMPONENTE DE NAVEGACIÓN PERSISTENTE (Mantiene fijada la barra inferior)
// =========================================================================

class PersistentBottomBarScaffold extends StatefulWidget {
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({super.key, required this.items});

  @override
  State<PersistentBottomBarScaffold> createState() =>
      _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    // Intercepta el botón físico/gesto de "atrás" del celular para que no cierre la app,
    // sino que retroceda la navegación interna de la pestaña actual.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        final currentNavigatorState = widget.items[_selectedTab].navigatorkey?.currentState;
        
        if (currentNavigatorState != null && currentNavigatorState.canPop()) {
          currentNavigatorState.pop();
        } else {
          // Si la pestaña actual ya está en su pantalla raíz, aquí se podría minimizar la app o no hacer nada.
          print("Ya estás en la raíz de la pestaña.");
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        
        // IndexedStack dibuja todas las pestañas pero solo muestra la activa,
        // reteniendo el estado y scrolls intactos de las otras.
        body: IndexedStack(
          index: _selectedTab,
          children: widget.items.map((page) {
            return Navigator(
              key: page.navigatorkey,
              onGenerateInitialRoutes: (navigator, initialRoute) {
                return [MaterialPageRoute(builder: (context) => page.tab)];
              },
            );
          }).toList(),
        ),

        // Barra inferior fija e independiente
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          type: BottomNavigationBarType.fixed, // Mantiene los iconos estables si son más de 3
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue.shade800, // Color institucional de tu preferencia
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: widget.items.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.title,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem({
    required this.tab,
    this.navigatorkey,
    required this.title,
    required this.icon,
  });
}