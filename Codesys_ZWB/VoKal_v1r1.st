PROGRAM VoKal

VAR_INPUT
    Komanda: INT;
    vremya_goda: INT;
    Tobr: REAL;
    N_Tobr_prog_let: REAL;
    N_Tobr_prog_zim: REAL;
    init_end: BOOL;
    rezhim1: INT;
    rezhim2: INT;
    Di_QF_Nasos: BOOL;
    Di_TS_VoKal: BOOL;
    N_niz_Tobr_let: REAL;
    N_niz_Tobr_zim: REAL;
END_VAR

VAR_OUTPUT
    Do_Nasos: BOOL;
    VK_progret: BOOL;
    A_net_pitaniya_Nasos: BOOL;
    A_Ygroza_zamorozki_TS: BOOL;
    A_Ygroza_zamorozki_Tpr: BOOL;
    A_Ygroza_zamorozki_Tobr: BOOL;
    A_Ygroza_zamorozki: BOOL;
END_VAR

VAR
    Init: INT := 0; // Инициализация
    Dezh: INT := 1; // Дежурный
    Preheat: INT := 2; // Предпрогрев
    Run: INT := 3; // Работа
    Prodyv: INT := 4; // Продувка
    Alarm: INT := 5; // Авария
    Block: INT := 6; // Блокировка
    Enable: BOOL; // Разрешение
END_VAR



IF vremya_goda = 0 AND Tobr > N_Tobr_prog_let AND init_end = TRUE AND rezhim2 = Preheat THEN
    VK_progret := TRUE;
END_IF;

IF vremya_goda = 1 AND Tobr > N_Tobr_prog_zim AND init_end = TRUE AND rezhim2 = Preheat THEN
    VK_progret := TRUE;
END_IF;

IF rezhim1 = 0 THEN (* Режим1 останов *)
    VK_progret := FALSE;
END_IF;

IF vremya_goda = 1 AND Di_QF_Nasos = TRUE THEN
    (* доделать *)
    Do_Nasos := TRUE;
END_IF;

IF vremya_goda = 0 THEN
    (* доделать *)
    Do_Nasos := FALSE;
END_IF;

IF Di_QF_Nasos = FALSE AND init_end = TRUE THEN
    (* доделать *)
    Do_Nasos := FALSE;
    A_net_pitaniya_Nasos := TRUE;
ELSE
    A_net_pitaniya_Nasos := FALSE;
END_IF;

IF Di_TS_VoKal = FALSE AND init_end = TRUE THEN
    A_Ygroza_zamorozki_TS := TRUE;
END_IF;

IF Di_TS_VoKal = TRUE AND init_end = TRUE THEN
    (* && Reset_alarm = TRUE *)
    A_Ygroza_zamorozki_TS := FALSE;
END_IF;

IF A_Ygroza_zamorozki_TS = TRUE OR A_Ygroza_zamorozki_Tpr = TRUE OR A_Ygroza_zamorozki_Tobr = TRUE THEN
    A_Ygroza_zamorozki := TRUE;
ELSE
    A_Ygroza_zamorozki := FALSE;
END_IF;

IF vremya_goda = 0 AND init_end = TRUE AND Tobr < N_niz_Tobr_let THEN
    A_Ygroza_zamorozki_Tobr := TRUE;
END_IF;

IF vremya_goda = 1 AND init_end = TRUE AND Tobr < N_niz_Tobr_zim THEN
    A_Ygroza_zamorozki_Tobr := TRUE;
END_IF;

IF vremya_goda = 0 AND init_end = TRUE AND Tobr >= N_Tobr_prog_let THEN
    A_Ygroza_zamorozki_Tobr := FALSE;
END_IF;

IF vremya_goda = 1 AND init_end = TRUE AND Tobr >= N_Tobr_prog_zim THEN
    A_Ygroza_zamorozki_Tobr := FALSE;
END_IF;

IF N_niz_Tobr_let + 5 > N_Tobr_prog_let THEN
    N_Tobr_prog_let := N_niz_Tobr_let + 5;
END_IF;

IF N_niz_Tobr_zim + 5 > N_Tobr_prog_zim THEN
    N_Tobr_prog_zim := N_niz_Tobr_zim + 5;
END_IF;

END_PROGRAM