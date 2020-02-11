clear;

prompt={'k:','T_1:','T_2:','T_3:','T_4:','T_5:','T_0:'};
name='Input';
numlines=1;
defaultanswer={'1','-1','2','3','5','5','9'}; 
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';

answer=inputdlg(prompt,name,numlines,defaultanswer,options);

k=str2num(answer{1,1});
T1=str2num(answer{2,1});
T2=str2num(answer{3,1});
T3=str2num(answer{4,1});
T4=str2num(answer{5,1}); 
T5=str2num(answer{6,1}); 
T0=str2num(answer{7,1});

regulowany = menu('Czy uklad ma zawierac regulator PID?', 'tak', 'nie');
switch (regulowany)
    case 1
        numerWybranegoWymuszenia = menu('Wybierz wymuszenie i zakłócenie', 'u(t)=1(t-10) z(t)=0', 'u(t)=1(t-10) z(t)=0.2*1(t-100)', 'u(t)=sin(0.01t)*1(t-10) z(t)=0', 'u(t)=sin(0.01t) z(t)=0.05[1(t)-cos(0.05t)]');
        sim('zRegulatorem',500);
    case 2
        numerWybranegoWymuszenia = menu('Wybierz wymuszenie', 'wymuszenie skokowe u(t)=1(t-10)', 'wymuszenie pulsowe u(t)=1(t-10)-1(t-11)'); 
        sim('bezRegulatora',500); 
end
  

plot(ans.dane, '.-')
xlabel('t(s)');
ylabel('y(t)');
legend('Syganl wymuszenia','Syganl odpowiedzi','Zakłócenie', 'Sterowanie');

[down up] = limits(ans.dane);
ylim([down up]);

function [lower, upper] = limits(dane)
    minimum=min(min(dane));
    maximum=max(max(dane));
    if minimum > 0 & maximum > 0
        lower = 0.9*minimum; 
        upper = 1.1*maximum;
    else
        if minimum < 0 & maximum > 0
            lower = 1.1*minimum; 
            upper = 1.1*maximum;
        else
            lower = 1.1*minimum; 
            upper = 0.9*maximum;
        end
    end
end
