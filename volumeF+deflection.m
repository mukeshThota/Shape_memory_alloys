T = sym('T','real');  %temperature
sigma = sym('sig','real'); %stress
Ti = sym('Ti','real');  %initialtemperature
volF = sym('Vf','real'); %volume fraction of martensite
Mf = 35; %martensite finish temp
Ms = 45; %martensite start temp
Af = 39; %austenite start temp
As = 51.5; %austenite final temp
Cm = 7*10^(6); %specific heat cap of martensite
Ca = 7*10^(6); %specific heat cap of austenite
Ea = 36.5*10^(9);
Er = 20*10^(9);
U = 0.43;
a = 5.77*10^(-3)
D = 6.3*10^(-3);
d = 0.75*10^(-3);
n=24;
F=0.7;
Ts = 8*F*D/(pi*d*d*d);
Mst = @(sig)(Ms+ sig/Cm);
Mft = @(sig)(Mf+ sig/Cm);
Ast = @(sig)(As+ sig/Ca);
Aft = @(sig)(Af+ sig/Ca);
deltaT = 10;
TArr = 0:deltaT:70;
deltaTi = 5;
TiArr = 30:deltaTi:65;
deltaS = 10*10^(6);
SArr = 0:deltaS:70*10^(6);
VfArr = zeros(1,length(TArr));
DArr = zeros(1,length(TArr));
for i=1:length(TArr)
    T = TiArr(i)+TArr(i);
    sig = SArr(i);
    if (TArr(i)>0)
        if (T <Ast(sig))
            VfArr(:,i) = 1;
        elseif (T < Aft(sig) && T>Ast(sig))
            VfArr(:,i) = (Af +(sig/Ca)-T)/Af-As ;
        elseif (T > Aft(sig))
            VfArr(:,i) = 0;
        end
    else
        if (T >Mst(sig))
            VfArr(:,i) = 0;
        elseif (T < Mst(sig) && T>Mft(sig))
            VfArr(:,i) = (Af +(sig/Ca)-T)/Af-As ;
        elseif (T < Mft(sig))
            VfArr(:,i) = 1;
        end
    end
    DArr(:,i) = (pi*n*D*D/d)*((Ts/(Ea*(1-VfArr(:,i))+Er*(VfArr(:,i))))+(((U)-a*(TArr(i)))*VfArr(:,i)));
end
%plot(TiArr,VfArr(1,:));
plot(TiArr,DArr(1,:));
   
        
    
    

    
