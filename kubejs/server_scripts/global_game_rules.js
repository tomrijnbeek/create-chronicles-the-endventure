ServerEvents.loaded(e => {
  e.server.gameRules.set("doPatrolSpawning", false)
  e.server.gameRules.set("doTraderSpawning", false)
})
