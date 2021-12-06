# @summary This is template plan contains logic to handle cross platform tasks.
# @param targets The targets to run on.
plan tasks_plans_workshop::cross_platform_example(
  TargetSpec $targets,
  String[4] $myparam,
) {

  out::message('Checking OS version')
  
  # Use puppet agent/facter to determine target OS for further actions below - apply_prep installs puppet agent in dormant state to enable profiling of targets facts via facter (built into puppet agent). 
    $targets.apply_prep
  
    $win_targets = get_targets($targets).group_by |$target| { $target.facts['kernel'] }['windows']
    $nix_targets = get_targets($targets).group_by |$target| { $target.facts['kernel'] }['Linux']
  
  out::message('Running mytask for each OS')
  
  # Basic if else statement to ensure each task runs on a compatible target
    if ($win_targets) {
      #run_task('tasks_plans_workshop::mytask', $win_targets, {'myparam' => 'hello world' })
      run_command('ipconfig /all', $win_targets)
    } elsif ($nix_targets) {
      #run_task('tasks_plans_workshop::mytask', $nix_targets, {'myparam' => 'hello world' })
      run_command('ip a', $nix_targets)
    } else  {
      fail_plan('OS is not compatible!')
  }
}
