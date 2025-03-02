pizzaBase = instance_find(oPizzaBase, 0);
if(pizzaBase != noone){
    with(pizzaBase){
        path_start(pathPizzaGameEnd, 4, path_action_stop, false);
    }
}
