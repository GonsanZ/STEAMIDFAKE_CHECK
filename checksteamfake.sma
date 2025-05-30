#include <amxmodx>

#define INVALID_STEAMID "STEAM_0:0:0"

new g_PlayerSteamID[33][32]; // Almacena SteamID como string para cada jugador

public plugin_init()
{
    register_plugin("Chequea STEAMIDFAKE", "1.0", "GonsanZ");
    register_clcmd("say /checksteam", "cmd_check_steam");
}

// Se ejecuta cuando el jugador ha sido autenticado por Steam
public client_authorized(id)
{
    new steamID[32];
    get_user_authid(id, steamID, charsmax(steamID));

    // Verificar si el SteamID es inválido
    if (is_invalid_steamid(steamID))
    {
        new name[32];
        get_user_name(id, name, charsmax(name));

        log_amx("[STEAMID FAKE] Jugador %s con SteamID inválido: %s", name, steamID);

        // Expulsar al jugador
        server_cmd("kick #%d ^"Falsificación de SteamID detectada.^"", get_user_userid(id));
    }
    else
    {
        // Guardar SteamID válido
        copy(g_PlayerSteamID[id], charsmax(g_PlayerSteamID[]), steamID);
    }
}

// Función para verificar si el SteamID es inválido
public bool:is_invalid_steamid(const steamID[])
{
    return equal(steamID, INVALID_STEAMID);
}

// Comando /checksteam para ver tu SteamID
public cmd_check_steam(id)
{
    new steamID[32];
    get_user_authid(id, steamID, charsmax(steamID));

    if (is_invalid_steamid(steamID))
    {
        client_print(id, print_chat, "[STEAMID] Tu SteamID es inválido!");
    }
    else
    {
        client_print(id, print_chat, "[STEAMID] Tu SteamID es válido: %s", steamID);
    }

    return PLUGIN_HANDLED;
}
