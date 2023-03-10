part of 'container_cubit.dart';

@immutable
class ContainerState {
  const ContainerState({
    required this.containerModel,
    this.isLoading = false,
  });

  final ContainerModel containerModel;
  final bool isLoading;

  ContainerState copyWith({
    ContainerModel? containerModel,
    bool? isLoading,
  }) {
    return ContainerState(
      containerModel: containerModel ?? this.containerModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
