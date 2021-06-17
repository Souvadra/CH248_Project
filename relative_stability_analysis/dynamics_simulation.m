function dydt = dynamics_simulation(t,y,parameter_set)

    dydt = zeros(10,1);
    Start = y(1);
    SK = y(2);
    Ste9 = y(3);
    Rum1 = y(4);
    Cdc2byCdc13 = y(5);
    Cdc2byCdc13Star = y(6);
    Wee1byMik1 = y(7);
    Cdc25 = y(8);
    PP = y(9);
    Slp1 = y(10);
    
    
    ga = parameter_set.("Prod_of_Start                ");
    gb = parameter_set.("Prod_of_SK                   ");
    gc = parameter_set.("Prod_of_Ste9                 ");
    gd = parameter_set.("Prod_of_Rum1                 ");
    ge = parameter_set.("Prod_of_Cdc2/Cdc13           ");
    gf = parameter_set.("Prod_of_Cdc2/Cdc13*          ");
    gg = parameter_set.("Prod_of_Wee1/Mik1            ");
    gh = parameter_set.("Prod_of_Cdc25                ");
    gi = parameter_set.("Prod_of_PP                   ");
    gj = parameter_set.("Prod_of_Slp1                 ");
    
    ka = parameter_set.("Deg_of_Start                 ");
    kb = parameter_set.("Deg_of_SK                    ");
    kc = parameter_set.("Deg_of_Ste9                  ");
    kd = parameter_set.("Deg_of_Rum1                  ");
    ke = parameter_set.("Deg_of_Cdc2/Cdc13            ");
    kf = parameter_set.("Deg_of_Cdc2/Cdc13*           ");
    kg = parameter_set.("Deg_of_Wee1/Mik1             ");
    kh = parameter_set.("Deg_of_Cdc25                 ");
    ki = parameter_set.("Deg_of_PP                    ");
    kj = parameter_set.("Deg_of_Slp1                  ");
    
    H_Start_Start = hill(Start, parameter_set.("Trd_of_StartToStart          "), parameter_set.("Inh_of_StartToStart          "), parameter_set.("Num_of_StartToStart          "));
    H_SK_Start = hill(SK, parameter_set.("Trd_of_SKToSK                "), parameter_set.("Act_of_SKToSK                "), parameter_set.("Num_of_SKToSK                "));
    
    H_Start_SK = hill(Start, parameter_set.("Trd_of_StartToSK             "), parameter_set.("Act_of_StartToSK             "), parameter_set.("Num_of_StartToSK             "));
    
    H_Cdc2byCdc13Star_Ste9 = hill(Cdc2byCdc13Star, parameter_set.("Trd_of_Cdc2/Cdc13*ToSte9     "), parameter_set.("Inh_of_Cdc2/Cdc13*ToSte9     "), parameter_set.("Num_of_Cdc2/Cdc13*ToSte9     "));
    H_SK_Ste9 = hill(SK, parameter_set.("Trd_of_SKToSte9              "), parameter_set.("Inh_of_SKToSte9              "), parameter_set.("Num_of_SKToSte9              "));
    H_Cdc2byCdc13_Ste9 = hill(Cdc2byCdc13, parameter_set.("Trd_of_Cdc2/Cdc13ToSte9      "), parameter_set.("Inh_of_Cdc2/Cdc13ToSte9      "), parameter_set.("Num_of_Cdc2/Cdc13ToSte9      "));
    H_PP_Ste9 = hill(PP, parameter_set.("Trd_of_PPToSte9              "), parameter_set.("Act_of_PPToSte9              "), parameter_set.("Num_of_PPToSte9              "));
    
    H_SK_Rum1 = hill(SK, parameter_set.("Trd_of_SKToRum1              "), parameter_set.("Inh_of_SKToRum1              "), parameter_set.("Num_of_SKToRum1              "));
    H_Cdc2byCdc13_Rum1 = hill(Cdc2byCdc13, parameter_set.("Trd_of_Cdc2/Cdc13ToRum1      "), parameter_set.("Inh_of_Cdc2/Cdc13ToRum1      "), parameter_set.("Num_of_Cdc2/Cdc13ToRum1      "));
    H_Cdc2byCdc13Star_Rum1 = hill(Cdc2byCdc13Star, parameter_set.("Trd_of_Cdc2/Cdc13*ToRum1     "), parameter_set.("Inh_of_Cdc2/Cdc13*ToRum1     "), parameter_set.("Num_of_Cdc2/Cdc13*ToRum1     "));
    H_PP_Rum1 = hill(PP, parameter_set.("Trd_of_PPToRum1              "), parameter_set.("Act_of_PPToRum1              "), parameter_set.("Num_of_PPToRum1              "));
    
    H_Rum1_Cdc2byCdc13 = hill(Rum1, parameter_set.("Trd_of_Rum1ToCdc2/Cdc13      "), parameter_set.("Inh_of_Rum1ToCdc2/Cdc13      "), parameter_set.("Num_of_Rum1ToCdc2/Cdc13      "));
    H_Ste9_Cdc2byCdc13 = hill(Ste9, parameter_set.("Trd_of_Ste9ToCdc2/Cdc13      "), parameter_set.("Inh_of_Ste9ToCdc2/Cdc13      "), parameter_set.("Num_of_Ste9ToCdc2/Cdc13      "));
    H_Slp1_Cdc2byCdc13 = hill(Slp1, parameter_set.("Trd_of_Slp1ToCdc2/Cdc13      "), parameter_set.("Inh_of_Slp1ToCdc2/Cdc13      "), parameter_set.("Num_of_Slp1ToCdc2/Cdc13      "));
    
    H_Cdc2byCdc13_Wee1byMik1 = hill(Cdc2byCdc13, parameter_set.("Trd_of_Cdc2/Cdc13ToWee1/Mik1 "), parameter_set.("Inh_of_Cdc2/Cdc13ToWee1/Mik1 "), parameter_set.("Num_of_Cdc2/Cdc13ToWee1/Mik1 "));
    H_PP_Wee1byMik1 = hill(PP, parameter_set.("Trd_of_PPToWee1/Mik1         "), parameter_set.("Act_of_PPToWee1/Mik1         "), parameter_set.("Num_of_PPToWee1/Mik1         "));
    
    H_Cdc2byCdc13_Cdc25 = hill(Cdc2byCdc13, parameter_set.("Trd_of_Cdc2/Cdc13ToCdc25     "), parameter_set.("Act_of_Cdc2/Cdc13ToCdc25     "), parameter_set.("Num_of_Cdc2/Cdc13ToCdc25     "));
    H_PP_Cdc25 = hill(PP, parameter_set.("Trd_of_PPToCdc25             "), parameter_set.("Inh_of_PPToCdc25             "), parameter_set.("Num_of_PPToCdc25             "));
    
    H_Cdc2byCdc13Star_Slp1 = hill(Cdc2byCdc13Star, parameter_set.("Trd_of_Cdc2/Cdc13*ToSlp1     "), parameter_set.("Act_of_Cdc2/Cdc13*ToSlp1     "), parameter_set.("Num_of_Cdc2/Cdc13*ToSlp1     "));
    H_Slp1_Slp1 = hill(Slp1, parameter_set.("Trd_of_Slp1ToSlp1            "), parameter_set.("Inh_of_Slp1ToSlp1            "), parameter_set.("Num_of_Slp1ToSlp1            "));
    
    H_PP_PP = hill(PP, parameter_set.("Trd_of_PPToPP                "), parameter_set.("Inh_of_PPToPP                "), parameter_set.("Num_of_PPToPP                "));
    H_Slp1_PP = hill(Slp1, parameter_set.("Trd_of_Slp1ToPP              "), parameter_set.("Act_of_Slp1ToPP              "), parameter_set.("Num_of_Slp1ToPP              "));
    
    H_Slp1_Cdc2byCdc13Star = hill(Slp1, parameter_set.("Trd_of_Slp1ToCdc2/Cdc13*     "), parameter_set.("Inh_of_Slp1ToCdc2/Cdc13*     "), parameter_set.("Num_of_Slp1ToCdc2/Cdc13*     "));
    H_Wee1byMik1_Cdc2byCdc13Star = hill(Wee1byMik1, parameter_set.("Trd_of_Wee1/Mik1ToCdc2/Cdc13*"), parameter_set.("Inh_of_Wee1/Mik1ToCdc2/Cdc13*"), parameter_set.("Num_of_Wee1/Mik1ToCdc2/Cdc13*"));
    H_Cdc25_Cdc2byCdc13Star = hill(Cdc25, parameter_set.("Trd_of_Cdc25ToCdc2/Cdc13*    "), parameter_set.("Act_of_Cdc25ToCdc2/Cdc13*    "), parameter_set.("Num_of_Cdc25ToCdc2/Cdc13*    "));
    H_Ste9_Cdc2byCdc13Star = hill(Ste9, parameter_set.("Trd_of_Ste9ToCdc2/Cdc13*     "), parameter_set.("Inh_of_Ste9ToCdc2/Cdc13*     "), parameter_set.("Num_of_Ste9ToCdc2/Cdc13*     "));
    H_Rum1_Cdc2byCdc13Star = hill(Rum1, parameter_set.("Trd_of_Rum1ToCdc2/Cdc13*     "), parameter_set.("Inh_of_Rum1ToCdc2/Cdc13*     "), parameter_set.("Num_of_Rum1ToCdc2/Cdc13*     "));
    
    
    dydt(1) = ga * H_Start_Start * H_SK_Start - ka*Start;
    dydt(2) = gb * H_Start_SK - kb*SK;
    dydt(3) = gc * H_Cdc2byCdc13Star_Ste9 * H_SK_Ste9 * H_Cdc2byCdc13_Ste9 * H_PP_Ste9 - kc*Ste9;
    dydt(4) = gd * H_SK_Rum1 * H_Cdc2byCdc13_Rum1 * H_Cdc2byCdc13Star_Rum1 * H_PP_Rum1 - kd*Rum1;
    dydt(5) = ge * H_Rum1_Cdc2byCdc13 * H_Ste9_Cdc2byCdc13 * H_Slp1_Cdc2byCdc13 - ke*Cdc2byCdc13;
    dydt(6) = gf * H_Slp1_Cdc2byCdc13Star * H_Wee1byMik1_Cdc2byCdc13Star * H_Cdc25_Cdc2byCdc13Star * H_Ste9_Cdc2byCdc13Star * H_Rum1_Cdc2byCdc13Star - kf*Cdc2byCdc13Star;
    dydt(7) = gi * H_Cdc2byCdc13_Wee1byMik1 * H_PP_Wee1byMik1 - ki*Wee1byMik1;
    dydt(8) = gj *H_Cdc2byCdc13_Cdc25 * H_PP_Cdc25 - kj*Cdc25;
    dydt(9) = gg * H_PP_PP * H_Slp1_PP - kg*PP;
    dydt(10) = gh * H_Cdc2byCdc13Star_Slp1 * H_Slp1_Slp1 - kh*Slp1;
    %dydt
end

