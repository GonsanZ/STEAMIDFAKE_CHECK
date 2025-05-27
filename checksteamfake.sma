#include <amxmodx>
#include <fakemeta>
#include <steam>
#include <color>

#define INVALID_STEAMID "STEAM_0:0:0"

new g_PlayerSteamID[33]; // Almacena SteamID para cada jugador

// Función para verificar el SteamID
public plugin_init()
{
	register_plugin("Chequea STEAMIDFAKE", "1.0", "GonsanZ")
    register_clcmd("say /checksteam", "cmd_check_steam");  // Comando para verificar SteamID
    register_event("HLTV", "on_hltv_connect", "a");  // Comando para capturar conexión de jugadores
    register_clcmd("say /checksteam", "cmd_check_steam");
}

// Callback para cuando un jugador se conecta
public on_hltv_connect(id)
{
    if (is_user_connected(id))
    {
        new steamID[32];
        get_user_steamid(id, steamID, sizeof(steamID));
        
        if (is_invalid_steamid(steamID))
        {
            // Bloqueamos al jugador si el SteamID no es válido
            kick(id, "Falsificación de SteamID detectada.");
        }
        else
        {
            g_PlayerSteamID[id] = steamID;
        }
    }
}

// Verifica si el SteamID es falso
public is_invalid_steamid(const steamID[])
{
    // Compara si el SteamID es igual al que hemos definido como "inválido"
    if (equal(steamID, INVALID_STEAMID))
    {
        return true;
    }

    return false;
}

// Comando de verificación manual de SteamID
public cmd_check_steam(id)
{
    new steamID[32];
    get_user_steamid(id, steamID, sizeof(steamID));

    if (is_invalid_steamid(steamID))
    {
        client_print(id, print_chat, "Tu SteamID es inválido!");
    }
    else
    {
        client_print(id, print_chat, "Tu SteamID es válido!");
    }
}