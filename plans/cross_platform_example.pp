# @summary Simple example plan showing cross platform capability
# @param targets The targets to run on.
plan tasks_plans_workshop::cross_platform_example(
  TargetSpec $targets,
) {

  run_command('hostname', $targets)
  out::message('Checking OS version')

  $targets.apply_prep

  $win_targets = get_targets($targets).group_by |$target| { $target.facts['kernel'] }['windows']
  $nix_targets = get_targets($targets).group_by |$target| { $target.facts['kernel'] }['Linux']

  out::message('Running mytask for each OS')

  # Basic if else statement to ensure each task runs on a compatible target
  if ($win_targets) {
    run_command('ipconfig /all', $win_targets)
    run_task('tasks_plans_workshop::winsysinfo', $win_targets)
  }
  if ($nix_targets) {
    run_command('ip a', $nix_targets)
    run_task('tasks_plans_workshop::lnxsysinfo', $nix_targets)
  }
}
