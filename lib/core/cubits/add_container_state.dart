part of 'add_container_cubit.dart';

@immutable
class AddContainerState {
  const AddContainerState({
    this.name,
    this.isLoading = false,
  });

  final String? name;
  final bool isLoading;

  AddContainerState copyWith({
    String? name,
    bool? isLoading,
  }) {
    return AddContainerState(
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
