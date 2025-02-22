program DesafioEscalada;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, Windows;

var
  profundidade, sobe, cai, alturaAtual, subidas: Integer;
  noBuraco: Boolean;
  hConsole: THandle;
  passouMetade: Boolean;
  resposta: Char;

begin
  try
    // Obtendo o handle do console
    hConsole := GetStdHandle(STD_OUTPUT_HANDLE);

    // Explica��o do processo
    WriteLn('Simulando a subida de uma minhoca que sobe e desce em um buraco.');
    WriteLn('A minhoca sobe uma quantidade fixa e depois cai uma certa quantidade, pausando por 1 segundo ao cair.');
    WriteLn('O programa ir� mostrar quando a minhoca chegar � metade do caminho e quando sair do buraco.');
    WriteLn;

    repeat
      // Entradas do usu�rio com valida��o
      repeat
        Write('Informe a profundidade do buraco (em cm): ');
        ReadLn(profundidade);
        if profundidade <= 0 then
          WriteLn('Valor inv�lido. A profundidade deve ser um n�mero positivo.');
      until profundidade > 0;

      repeat
        Write('Informe a quantidade que a minhoca sobe (em cm): ');
        ReadLn(sobe);
        if sobe <= 0 then
          WriteLn('Valor inv�lido. A quantidade que a minhoca sobe deve ser um n�mero positivo.');
      until sobe > 0;

      repeat
        Write('Informe a quantidade que a minhoca cai (em cm): ');
        ReadLn(cai);
        if cai <= 0 then
          WriteLn('Valor inv�lido. A quantidade que a minhoca cai deve ser um n�mero positivo.');
      until cai > 0;

      // Inicializa��o das vari�veis
      alturaAtual := 0;
      subidas := 0;
      noBuraco := True;
      passouMetade := False;

      // Loop para simular a subida da minhoca
      while noBuraco do
      begin
        // Minhoca sobe
        alturaAtual := alturaAtual + sobe;
        Inc(subidas);

        // Exibe a posi��o atual da minhoca
        WriteLn('A minhoca subiu para ', alturaAtual, ' cm.');

        // Verifica se chegou � metade do caminho
        if (alturaAtual >= profundidade div 2) and not passouMetade then
        begin
          SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY or FOREGROUND_RED or FOREGROUND_GREEN);
          // Exibe mensagem para a metade do caminho
          WriteLn('A minhoca chegou � metade do caminho!');
          passouMetade := True;  // Marca que passou pela metade
        end;

        // Verifica se saiu do buraco
        if alturaAtual >= profundidade then
        begin

          SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY or FOREGROUND_GREEN);
          // Exibe mensagem de sa�da do buraco
          WriteLn('A minhoca saiu do buraco!');
          noBuraco := False;
          Break;
        end
        else
        begin
          // Minhoca cai
          alturaAtual := alturaAtual - cai;
          if alturaAtual < 0 then
            alturaAtual := 0; // N�o pode descer abaixo do solo
          WriteLn('A minhoca caiu para ', alturaAtual, ' cm.');
          Sleep(1000); // Pausa de 1 segundo
        end;
      end;

      SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY or FOREGROUND_RED or FOREGROUND_GREEN or FOREGROUND_BLUE);

      // Exibindo o n�mero de subidas
      WriteLn('A minhoca subiu ', subidas, ' vezes.');

      // Pergunta se o usu�rio deseja tentar novamente
      WriteLn;
      Write('Voc� gostaria de tentar novamente? (S/N): ');
      ReadLn(resposta);

      // Resetando vari�veis para nova tentativa
      noBuraco := True;

    until (resposta = 'N') or (resposta = 'n');


    WriteLn('Obrigado por jogar!');
    WriteLn('Pressione qualquer tecla para sair...');
    ReadLn;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

