# @summary Example cross-platform plan to install a Webserver
# @param targets The targets to run on.

plan tasks_plans_workshop::webserver(
  TargetSpec $targets,
) {

  $targets.apply_prep

  $win_targets = get_targets($targets).group_by |$target| { $target.facts['kernel'] }['windows']
  $nix_targets = get_targets($targets).group_by |$target| { $target.facts['kernel'] }['Linux']

  # Basic if else statement to ensure each task runs on a compatible target
  if ($win_targets) {
    out::message("Running task to install iis_server on Windows targets")
    run_task('tasks_plans_workshop::windowsfeature', $win_targets, {'action' => 'install', feature => 'Web-Server'})
  }
  if ($nix_targets) {
    out::message("Running plan to install Apache on Linux targets")
    run_plan('tasks_plans_workshop::install_apache', $nix_targets)
  }
}

# bolt task run tasks_plans_workshop::windowsfeature action='uninstall' feature='Web-Server' --inventory ./inventory-ka231221.yaml --targets ka231221win0.se.automationdemos.com
