letterController = instance_find(oLetterOnDashes, 0);
if(letterController != noone){
    previousWord = "";
} else {
    show_debug_message("oRoleController Error: No instance of oLetterOnDashes found.");
}
pizzaBase = instance_find(oPizzaBase, 0);
if(pizzaBase == noone){
    show_debug_message("oRoleController Error: No instance of oPizzaBase found.");
}
if(!variable_global_exists("pizzaItems") || global.pizzaItems == undefined){
    global.pizzaItems = ds_list_create();
}
global.gameComplete = false;
pizzaBasePathStarted = false;
