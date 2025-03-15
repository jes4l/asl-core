global.client_socket = network_create_socket(network_socket_tcp);
server_socket = network_connect_raw_async(global.client_socket, "127.0.0.1", 36042);
originalString = "";
global.connectionStatus = "Disconnected";
global.lastMessageTime = current_time;
global.lastReceivedMessage = "";
window_set_fullscreen(!window_get_fullscreen());