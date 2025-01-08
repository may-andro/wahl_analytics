enum DISetUpStatus {
  warmup, // when the dependency injection has started
  fetch, // fetching of data has started
  register, // registering the dependencies in dependency graph
  done, // all dependencies have been registered
}
