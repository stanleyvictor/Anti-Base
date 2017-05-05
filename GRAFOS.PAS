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
opcao       : char;         {op‡Ço de sair ou escrever outro arquivo}

{============ VARIAVEIS DOS ALUNOS =============}

poss : Array[1..100] of integer; //vetor de vertices que possivelmente sao anti-base {|n| = vertice possivelmente anti-base ; |0| = vertice nao anti-base}

{======= FIM DAS VARIAVEIS DOS ALUNOS ==========}

Label 123, 456;

function digrafo (nvert:integer): boolean;
begin
digrafo := false;
        for i1 := 1 to nvert do
            for j1 := 1 to nvert do
                if ( (MAdjacencia [i1,j1] <> MAdjacencia [j1,i1]) or (nvert = 1){trivial}) then
                digrafo := true;
end;


begin
sair := false;
while not sair do
begin
     textbackground(1);
     clrscr;
     arqok := false;
     while not arqok do         {Verificando a existencia do arquivo}
     begin
          write('Digite o nome do arquivo ou S para sair: ');
          readln (nomearquivo);
          if ((nomearquivo = 's') or (nomearquivo = 'S')) then goto 456;    
          nomearquivo := Concat (nomearquivo, '.txt');
          if Fsearch (nomearquivo,'') <> '' then
          begin
               arqok := true;
               writeln('Arquivo localizado com sucesso!');
               readkey;
               clrscr;
          end
          else
          begin
               writeln ('Arquivo inexistente, tente novamente!')
          end;
     end;

     for i := 1 to 100 do
     for j := 1 to 100 do
     MAdjacencia [i,j] := 0;

     writeln('Trabalhos dos alunos: Otavio Cornelio e Stanley Victor');
     writeln(' ');

     writeln('Matriz de Adjacencia do Grafo no arquivo:');
     writeln(' ');

     assign (arquivo, nomearquivo);
     reset (arquivo);

     snumero := '';
     i := 1;    {Preenchimento inicial na linha  1 }
     j := 1;    {Preenchimento inicial na coluna 1 }
     m := 0;

     While not eof (arquivo) do         {Preenchimento da Matriz de Adjacencia do Grafo}
     begin

          read(arquivo, auxarq);

          if (auxarq <> ' ') and (auxarq <> chr(13)) and (auxarq <> chr(10)) then
          begin
               snumero := concat (snumero,auxarq);
          end
          else
          begin
               val (snumero,inumero,erro);

               if (erro <> 0) and (auxarq <> chr(10)) then
               begin
                    Writeln('Erro: ', erro,'. Arquivo nao possui um grafo');
                    readkey;
                    goto 123;
               end;
                              
               snumero := '';
               MAdjacencia [i,j] := inumero;

               if inumero <> 0 then m := m + 1; {Definindo a quantidade de Arestas Dirigidas em digrafos}


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
               end;
          end;          {do if}
     end;               {do while eof}


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
               for j1 := 1 to i do
               begin
                       if (MAdjacencia [i1,j1] <> 0) then   
                          m := m + 1;
               end;
     end
     else
     begin
          for i1 := 1 to i do
          for j1 := 1 to i do
          begin
                  if (MAdjacencia [i1,j1] <> 0) and (i1 < j1)then
                  m := m + 1;
           end;
 
           for i1 := 1 to i do                      //Contando od la‡os
           if (MAdjacencia [i1,i1] <> 0) then
                m := m + 1;         
     end;          


    
     writeln('');
     writeln('');
     writeln('n= ',n, ' e m= ', m);

     close(arquivo);
     readkey;

{=== CODIGOS DEVEM SER IMPLEMENTADOS A PARTIR DESTA LINHA ====}

     if digrafo(n) then
     begin
          writeln('E digrafo! Calculando Anti-base...');

          for i:=1 to n do //linhas
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

               //resultados
               writeln;
               write('Vertices da Anti-Base:');
               for i:=1 to n do
               begin
                    if (poss[i] <> 0) then
                       write('|v',poss[i]);
               end;
               write('|');
               writeln;
               //fimresultados

               //debug {mostra o vetor de possibilidades inteiro}
               writeln;
               for i:=1 to n do
                   write(poss[i],',');
               writeln;
               //fim debug

     end else begin //fim do if(digrafo)
         writeln('Nao e digrafo! Anti-base so existe em digrafo, tente novamente!');
     end;

{=== FIM DOS CODIGOS DOS ALUNOS ====}

123:
     write ('Digite S para sair ou Enter para um novo arquivo: ');
     opcao:=ReadKey;
     opcao:=UpCase(opcao); 
     if opcao = 'S' then 
          sair := true;
end;
456:
end.
