function result = Kuroda(Az, u, v, epsilon = 0.01, maxim = 10000) # RAS!!!!itt = 0;    do        if (rem(itt, 2) == 0);      udot = sum(Az, 2);      R = diag(u ./ udot);      R(or(isinf(R), isnan(R))) = 0;      Az = R * Az;    else      vdot = sum(Az, 1);      S = diag(v ./ vdot);      S(or(isinf(S), isnan(S))) = 0;      Az = Az * S;    endif        itt += 1;        unow = sum(Az, 2);    vnow = sum(Az, 1);    diffU = abs(u .- unow);    diffV = abs(v .- vnow);      until(or(        and(all(diffU < epsilon),            all(diffV < epsilon)),        itt > maxim))    result = Az;  endfunction