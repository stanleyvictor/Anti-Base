Program AlgoritmoemGrafos;
uses crt, dos;

var
MAdjacencia : Array [1..100,1..100] of integer; {Matriz de Adjacencia do Grafo}
n,m         : Integer;      {Quantidade de Vertices e de Arestas direcionadas do Grafo}
arquivo     : Text;         {Arquivo texto onde esta o Grafo}
arqok       : Boolean;      {Arquivo encontrado ou nao}
nomearquivo : String;       {Nome do arquivo a ser utilizado}
Auxarq      : Char;         {Auxiliar para colocar os dados do arquivo na matriz}
Snumero     : String;       {Numero do arquivo em formato String}
Inumero     : Integer;      {Numero do arquivo em formato inteiro}
I, J, i1, j1: Integer;      {Auxiliares para varrer a matriz}
erro        : Integer;      {Erro na transformacao de String para Inteiro}
Sair        : boolean;      {Sai do programa ou pede outro arquivo}
opcao       : char;         {op��o de sair ou escrever outro arquivo}

{============ VARIAVEIS DOS ALUNOS =============}

poss : Array[1..100] of integer; //vetor de vertices que possivelmente sao anti-base
{|n| = vertice possivelmente anti-base ; |0| = vertice nao anti-base}
caminho : Array[1..100,1..100] of integer;//vetor de caminho entre vertices
{|n| = existe um caminho entre este vertice e o vertice atual ; |0| = nulo}
aux : integer;
excaminho : boolean; //existe caminho

{======= FIM DAS VARIAVEIS DOS ALUNOS ==========}

Label 123, 456;

function digrafo (nvert:integer): boolean; {Funcao para saber se eh digrafo ou nao}
  begin
    digrafo := false;
      for i1 := 1 to nvert do
        for j1 := 1 to nvert do
          if ( (MAdjacencia [i1,j1] <> MAdjacencia [j1,i1]){Verifica se a matriz eh espelhada, se não entao é digrafo} or (nvert = 1){trivial}) then
            digrafo := true;
end; {Function Digrafo}

begin {Bloco principal}
  sair := false;
  while not sair do {O(N)}
    begin
      textbackground(1);
      clrscr;
      arqok := false;            {Arquivo ainda n�o encontrado}
      while not arqok do {O(N�)}         {Enquanto o arquivo n�o for encontrado, executa o c�digo abaixo}
        begin
          write('Digite o nome do arquivo ou S para sair: ');
          readln (nomearquivo);
          if ((nomearquivo = 's') or (nomearquivo = 'S')) then
            goto 456;    {Caso digite S/s, o goto ir� para o final do programa}
          nomearquivo := Concat (nomearquivo, '.txt'); {Caso contr�rio concatene o nome do arquivo com .txt}
          if Fsearch (nomearquivo,'') <> '' then {Caso o resultado da fun��o Fsearch seja diferente de '' ent�o o arquivo foi encontrado}
            begin
              arqok := true; {Arquivo encontrado}
              writeln('Arquivo localizado com sucesso!');
              readkey;
              clrscr;
            end
          else
            begin {Caso contr�rio feedback ao usu�rio e repete at� ser encontrado ou o usu�rio decidir sair}
              writeln ('Arquivo inexistente, tente novamente!')
            end;
      end; {While de procura do Arquivo}

      for i := 1 to 100 do
        for j := 1 to 100 do {O(N�)}
          MAdjacencia [i,j] := 0;

      writeln('Trabalhos dos alunos: Otavio Cornelio e Stanley Victor');
      writeln(' ');

      writeln('Matriz de Adjacencia do Grafo no arquivo:');
      writeln(' ');

      assign (arquivo, nomearquivo); {Associa��o da v�riavel do arquivo com o nome f�sico}
      reset (arquivo); {Abri o arquivo existente, permitindo escrita e leitura no mesmo}

      snumero := '';
      i := 1;    {Preenchimento inicial na linha  1 }
      j := 1;    {Preenchimento inicial na coluna 1 }
      m := 0;

      While not eof (arquivo) do {Enquanto n�o for encontrado o final do arquivo}//Preenchimento da Matriz de Adjacencia do Grafo
        begin
          read(arquivo, auxarq); {A auxiliar recebe os registros do arquivo}
          if (auxarq <> ' ') and (auxarq <> chr(13)) and (auxarq <> chr(10)) then
            begin
               snumero := concat (snumero,auxarq); {Concatena o n�mero do arquivo em String ao auxiliar}
            end
          else
            begin
              val (snumero,inumero,erro); {Converte o n�mero do arquivo para inteiro e joga em 'inumero', e retorna uma resposta caso d� erro}
              if (erro <> 0) and (auxarq <> chr(10)) then {Se a reposta for diferente de 0 (ocorreu erro) e o auxiliar for diferente de ''}
                begin
                  Writeln('Erro: ', erro,'. Arquivo nao possui um grafo');
                  readkey;
                  goto 123; {Pula para pedir novo arquivo ou sair do programa}
                end;

              snumero := '';
              MAdjacencia [i,j] := inumero;
              if inumero <> 0 then
                m := m + 1; {Definindo a quantidade de Arestas Dirigidas em digrafos}
              if auxarq = ' ' then
                begin
                  write (MAdjacencia [i,j], ' ');
                    j := j + 1;
                end
              else
                begin
                  if (auxarq <> chr(10)) then
                    begin
                      writeln (MAdjacencia [i,j], ' ');
                      i := i + 1;
                      j := 1;
                    end;
                end;     {2� else}
            end;          {Else do 1� if}
      end;  {O(N�)}             {While eof}


      val (snumero,inumero,erro);
      if (erro <> 0) and (auxarq <> chr(10)) then
        begin
          Writeln('Erro: ', erro,'. Arquivo nao possui um grafo');
          readkey;
          goto 123;
        end;
      MAdjacencia [i,j] := inumero;
      writeln (MAdjacencia [i,j], ' ');
      m := 0;
      n := i;
      if digrafo (n) then
        begin
          for i1 := 1 to i do
            for j1 := 1 to i do {O(N�)}
              begin
                if (MAdjacencia [i1,j1] <> 0) then
                  m := m + 1;
              end;
        end {If digrafo}
      else
        begin
          for i1 := 1 to i do
            for j1 := 1 to i do
              begin
                if (MAdjacencia [i1,j1] <> 0) and (i1 < j1)then
                  m := m + 1;
              end;

          for i1 := 1 to i do                      {Contando os la�os}
            if (MAdjacencia [i1,i1] <> 0) then
              m := m + 1;
        end;  {Else}

      writeln('');
      writeln('');
      writeln('n= ',n, ' e m= ', m); {Mostra a quantidade de v�rtices (N) e arestas (M)}

      close(arquivo); {Fecha o arquivo}
      readkey;

      {=== CODIGOS DEVEM SER IMPLEMENTADOS A PARTIR DESTA LINHA ====}

      if digrafo(n) then {Se for digrafo, vai procurar a anti-base, caso contr�rio vai para linha 331}
        begin
          writeln('E digrafo! Calculando Anti-base...');

          //|PERCORRE A MATRIZ DE ADJACENCIA E ADICIONA VETORES CUJAS LINHAS S� POSSUEM ZERO|
          for i:=1 to n do //linhas {O(N³)}
            begin
              poss[i] := i; //coloca o vertice no vetor de possibilidades
              for j:=1 to n do //colunas
                begin
                  if(i <> j)then //pula diagonal principal
                    begin
                      if(MAdjacencia[i,j] <> 0)then //possui 1 na linha atual ou nao
                        poss[i] := 0; //se sim, remove o vertice do vetor de possibilidades adicionando 0 na posicao
                    end;
                end;
            end;

          //|PREENCHIMENTO INICIAL DA MATRIZ DE CAMINHOS (apenas a primeira coluna)|

          for i:=1 to n do//linhas
            begin
              for j:=1 to n do//colunas
                begin
                  if(i <> j)then//pula diagonal principal
                    begin
                      if(MAdjacencia[i,j] <> 0)then
                        begin
                          caminho[i,j] := j;//adiciona vertice aos caminhos poss�veis
                        end
                      else
                        begin
                          caminho[i,j] := 0;//remove vertice dos caminhos poss�veis
                        end;
                    end
                  else
                    begin
                      caminho[i,j] := 0;//remove vertice [diag. principal] dos caminhos poss�veis
                    end;
                end;//fimcolunas
            end;//fimlinhas

          //|BUBBLE SORT NA MATRIZ DE CAMINHOS|

          if(n > 1)then//bubble sort na matriz de caminhos |OBS:Esse IF � gigante|
            begin//Come�oIF
              for i:=1 to n do//linhas
                begin
                  for i1:=1 to n-1 do//repeti��o do bubble sort na linha |as repeti��es seguem at� n-1|
                    begin
                      for j:=1 to n-1 do//colunas
                        begin
                          if(caminho[i,j] < caminho[i,j+1])then//faz a troca do BSORT caso o numero a frente for maior.
                            begin
                              aux := caminho[i,j];
                              caminho[i,j] := caminho[i,j+1];
                              caminho[i,j+1] := aux;
                            end;
                        end;//fimcolunas
                    end;//fimrepeti�ao
                end;//fimlinhas

               //|PREENCHIMENTO SECUND�RIO DA MATRIZ DE CAMINHOS(o restante das colunas)|

              for i:=1 to n do//linhas
                begin
                  for j:=1 to n do//colunas
                    begin
                      if(caminho[i,j] <> 0)then
                        begin
                          i1 := caminho[i,j];
                          j1 := 1;
                          while(caminho[i1,j1] <> 0)do
                            begin
                              caminho[i,j+1] := caminho[i1,j1];
                              inc(j1);
                              inc(j);
                            end;
                        end;
                    end;//fimcolunas
                end;//fimlinhas

              //|VERIFICA SE VERTICES PARA OS QUAIS 'V' POSSUI CAMINHO TAMBEM POSSUEM CAMINHO PARA 'V', SE SIM ADD AO VETOR DE POSSIBILIDADES|

              excaminho := false; //existe caminho?

              for i:=1 to n do//linhas
                begin
                  for j:=1 to n do//colunas
                    begin
                      if(caminho[i,j] <> 0)then
                        begin
                          i1 := caminho[i,j];
                          j1:= i;
                          if( (MAdjacencia[i1,j1] <> 0) and (excaminho = false) )then
                            begin
                              for i1:= 1 to n do
                                begin
                                  if( (poss[i1] = 0) and (excaminho = false) )then
                                    begin
                                      poss[i1] := i; //adiciona o vertice no vetor de possibilidades
                                      excaminho := true;//existe caminho
                                    end;
                                end;
                            end;
                        end;
                  end;//fimcolunas
                  excaminho := false;
                end;//fimlinhas

              //|FAZ UMA BUSCA PELO VETOR DE POSSIBILIDADES POR VERTICES QUE POSSUEM CAMINHOS ENTRE SI E REMOVE UM DELES|

              for i:=1 to n do
                begin
                  for aux:=1 to n do
                    if(i <> aux)then
                      begin
                        if( (poss[i] <> 0) and (poss[aux] <> 0) )then
                          begin
                            if(MAdjacencia[poss[i],poss[aux]] <> 0)then
                              poss[i] := 0;
                          end;
                      end;
                end;
          end; {Fim do IF GIGANTE}

          {Resultados}
          writeln;
          write('Vertices da Anti-Base:');
          for i:=1 to n do
            begin
              if (poss[i] <> 0) then
                write('|v',poss[i]);
            end;
          write('|');
          writeln;
          {Fim dos Resultados}

          //debug {mostra o vetor de possibilidades e caminhos inteiro}
          //{
          writeln('DEBUG');
          for i:=1 to n do
            write(poss[i],',');
          writeln;
          writeln;

          for i:=1 to n do
            begin
              for j:=1 to n do
                begin
                  write(caminho[i,j],' ');
                end;
              writeln;
          end;
          //}
          //fim debug

        end
      else
        begin //fim do if(digrafo)
          writeln('Nao e digrafo! Anti-base so existe em digrafo, tente novamente!');
        end;
      {=== FIM DOS CODIGOS DOS ALUNOS ====}
      123:
      write ('Digite S para sair ou Enter para um novo arquivo: ');
    opcao:=ReadKey;
    opcao:=UpCase(opcao);
    if opcao = 'S' then
      sair := true;
  end; {Primeiro While}
  456:
end. {Bloco principal}
