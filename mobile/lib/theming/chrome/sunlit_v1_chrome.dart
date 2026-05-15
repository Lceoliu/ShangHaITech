import 'chrome_bundle.dart';
import '../../shared/widgets/main_nav_bar.dart';

ChromeBundle sunlitV1ChromeBundle() => ChromeBundle(
      bottomNav: (context, currentIndex, items, onTap) =>
          MainNavBar(currentIndex: currentIndex, onChanged: onTap),
    );
