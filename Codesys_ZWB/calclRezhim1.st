PROGRAM calclRezhim1

VAR_INPUT
    konf_SA_Pusk_Stop : BOOL;
    P_rezhim_ypr : INT;
    Alarm_critical : BOOL;
    Di_sa_pusk_stop : BOOL;

    otM_Pusk : BOOL;
    otM_Stop : BOOL;
END_VAR

VAR_OUTPUT
    rezhim1 : BOOL;
END_VAR



// вычисление режима установки
IF konf_SA_Pusk_Stop = FALSE THEN
    P_rezhim_ypr := 1;
    // если переключателя пуск/стоп не предусмотрено, то переходим в режим управления дистанционный
    // и ждём команды на запуск от мастера
END_IF;

IF P_rezhim_ypr = 0 AND konf_SA_Pusk_Stop = TRUE THEN
    // если режим управления местный и есть переключатель пуск/стоп
    IF Alarm_critical = TRUE OR Di_sa_pusk_stop = FALSE THEN
        rezhim1 := FALSE;
    END_IF;
    IF Alarm_critical <> TRUE AND Di_sa_pusk_stop = TRUE THEN
        rezhim1 := TRUE;
    END_IF;
END_IF;

IF P_rezhim_ypr = 1 AND konf_SA_Pusk_Stop = TRUE THEN
    // режим дистанционный и есть переключатель пуск/стоп
    IF Di_sa_pusk_stop = TRUE THEN
        IF Alarm_critical = TRUE THEN
            rezhim1 := FALSE;
        END_IF;
        IF Alarm_critical <> TRUE AND otM_Pusk = TRUE THEN
            rezhim1 := TRUE;
            otM_Pusk := FALSE;
        END_IF;
        IF Alarm_critical <> TRUE AND otM_Stop = TRUE THEN
            rezhim1 := FALSE;
            otM_Stop := FALSE;
        END_IF;
    END_IF;
    IF Di_sa_pusk_stop = FALSE THEN
        rezhim1 := FALSE;
    END_IF;
END_IF;

IF P_rezhim_ypr = 1 AND konf_SA_Pusk_Stop = FALSE THEN
    // режим дистанционный и нет переключателя пуск/стоп
    IF Alarm_critical = TRUE THEN
        rezhim1 := FALSE;
    END_IF;
    IF Alarm_critical <> TRUE AND otM_Pusk = TRUE THEN
        rezhim1 := TRUE;
        otM_Pusk := FALSE;
    END_IF;
    IF Alarm_critical <> TRUE AND otM_Stop = TRUE THEN
        rezhim1 := FALSE;
        otM_Stop := FALSE;
    END_IF;
END_IF;
END_PROGRAM