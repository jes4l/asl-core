pizzaBase = instance_find(oPizzaBase, 0);
if (pizzaBase != noone) {
    pizzaBase.reachedEnd = false;
    with (pizzaBase) {
        path_start(pathPizzaGameEnd, 4, path_action_stop, false);
    }
}
