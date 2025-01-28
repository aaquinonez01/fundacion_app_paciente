import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class PageState {
  final int currentPage;
  final PageController pageController;

  PageState({
    required this.currentPage,
    required this.pageController,
  });

  // Método para copiar el estado con nuevas propiedades (si es necesario).
  PageState copyWith({
    int? currentPage,
    PageController? pageController,
  }) {
    return PageState(
      currentPage: currentPage ?? this.currentPage,
      pageController: pageController ?? this.pageController,
    );
  }
}

final pageControllerProvider =
    StateNotifierProvider<PageControllerNotifier, PageState>((ref) {
  return PageControllerNotifier();
});

class PageControllerNotifier extends StateNotifier<PageState> {
  PageControllerNotifier()
      : super(PageState(
            currentPage: 0, pageController: PageController(initialPage: 0)));

  // Método para ir a la siguiente página
  void nextPage() {
    if (state.currentPage < 2) {
      final nextPage = state.currentPage + 1;
      state = state.copyWith(currentPage: nextPage);
      state.pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      final prevPage = state.currentPage - 1;
      state = state.copyWith(currentPage: prevPage);
      state.pageController.animateToPage(
        prevPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Método para actualizar el estado de la página directamente
  void goToPage(int page) {
    if (page >= 0 && page <= 2) {
      state = state.copyWith(currentPage: page);
      state.pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}
