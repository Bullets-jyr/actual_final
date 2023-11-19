import 'package:actual_final/common/const/colors.dart';
import 'package:actual_final/common/layout/default_layout.dart';
import 'package:actual_final/product/view/product_screen.dart';
import 'package:actual_final/restaurant/view/restaurant_screen.dart';
import 'package:actual_final/user/view/profile_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener(){
    setState((){
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '블렛츠 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          // Center(child: Container(child: Text('홈'),)),
          RestaurantScreen(),
          // Center(child: Container(child: Text('음식'),)),
          ProductScreen(),
          Center(child: Container(child: Text('주문'),)),
          // Center(child: Container(child: Text('프로필'),)),
          ProfileScreen(),
          // ProductScreen(),
          // OrderScreen(),
          // ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}


// class RootTab extends StatefulWidget {
//   static String get routeName => 'home';
//
//   const RootTab({Key? key}) : super(key: key);
//
//   @override
//   State<RootTab> createState() => _RootTabState();
// }
//
// class _RootTabState extends State<RootTab>
//     with SingleTickerProviderStateMixin {
//   late TabController controller;
//
//   int index = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     controller = TabController(length: 4, vsync: this);
//
//     controller.addListener(tabListener);
//   }
//
//   @override
//   void dispose() {
//     controller.removeListener(tabListener);
//
//     super.dispose();
//   }
//
//   void tabListener(){
//     setState((){
//       index = controller.index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultLayout(
//       title: '코팩 딜리버리',
//       child: TabBarView(
//         physics: NeverScrollableScrollPhysics(),
//         controller: controller,
//         children: [
//           RestaurantScreen(),
//           ProductScreen(),
//           OrderScreen(),
//           ProfileScreen(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: PRIMARY_COLOR,
//         unselectedItemColor: BODY_TEXT_COLOR,
//         selectedFontSize: 10,
//         unselectedFontSize: 10,
//         type: BottomNavigationBarType.fixed,
//         onTap: (int index) {
//           controller.animateTo(index);
//         },
//         currentIndex: index,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: '홈',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fastfood_outlined),
//             label: '음식',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.receipt_long_outlined),
//             label: '주문',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outlined),
//             label: '프로필',
//           ),
//         ],
//       ),
//     );
//   }
// }