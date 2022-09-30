program RecuperatorioParcial;
const
  DimF=10;{cantidad de camion}
type
  {--Resgitro, lista  Y Vector de Listas--}

      Camion=record
          Ncamion:1..DimF;{SubRango va de 1 a 10}
          Ncalle:integer;
          Navenida:integer;
          cantObj:integer;
      end;
        Camion2=record
          Ncalle:integer;
          Navenida:integer;
          cantObj:integer;
      end;


      Lista=^Nodo;
      Nodo=record
          Dato:Camion2;
          Sig:Lista;
      end;

      Vec_Lista = array [1..DimF] of Lista;

   Reg=record
     av:integer;
     total:integer;
   end;

   Arbol=^NodoA;
   NodoA=record
      Dato:Reg;
      HI:Arbol;
      HD:Arbol;
   end;

  {--FIN--}
{--Cargamos El Vector De lista--}

procedure Inc_VecList(var VL:Vec_Lista);
var
  i:integer;
begin
  for i:=1 to DimF do
       VL[i]:=Nil;
end;
{Insiso A Modulo Cargar Aleatorio}
procedure LeeReg(var C:Camion);
begin
  Randomize;
  C.Ncamion:=random(10);
  if(C.Ncamion <> 0 )then begin
      C.Ncalle:=random (99)+1;
      C.Navenida:=random (99)+1;
      C.cantObj:=random (99)+1;
      writeln('');
  end;
end;

procedure Insert_Ord(var L:Lista; C:camion2);
var
  nue:Lista;
  Ant,Act:Lista;
begin
  new(nue);
  nue^.dato:=C;
  Ant:=L;
  Act:=L;
  while(Act <> Nil) and (Act^.dato.Navenida < C.Navenida)do begin
                      Ant:=Act;
                      Act:=Act^.sig;
  end;
  if(Act = L)then
         L:=nue
  else
         Ant^.sig:=nue;
  nue^.sig:=Act;
end;
procedure cargarDatos(C:camion;var C2:camion2);
begin
  C2.Ncalle:=C.Ncalle;
  C2.Navenida:=C.Ncalle;
  C2.cantObj:=C.cantObj;
end;

Procedure Carg_VL(var VL:Vec_Lista);
var
  C:Camion;
  C2:Camion2;
begin
  Inc_VecList(VL);
  LeeReg(C);
  while(C.Ncamion <> 0)do begin
      cargarDatos(C,C2);
      insert_Ord(vl[C.Ncamion],C2);
      LeeReg(C);
  end;
end;
{-- FIN --}
{--Merge Acumulador--}
procedure BuscarMinimo(var VL:Vec_Lista; var min:Camion2);
var
  pos,i:integer;
begin
  min.Navenida:=999;
  for i:=1 to DimF do begin
      if(VL[i] <> Nil)then begin
          if(vl[i]^.dato.Navenida < min.Navenida)then begin
              min:=vl[i]^.dato;
              pos:=i;
          end;
      end;
  end;
  if(min.Navenida <> 999)then begin
      VL[pos]:=VL[pos]^.sig;
  end;
end;


procedure Insertar(var A:Arbol;R:Reg);
begin
  if(A = Nil)then begin
      new(A);
      A^.dato:=R;
      A^.HI:=Nil;
      A^.HD:=Nil;
  end
  else begin
      if(R.Total < A^.dato.Total)then
          Insertar(A^.HI,R)
      else
          Insertar(A^.HD,R);
  end;
end;

procedure MergeAcumulador(VL:Vec_Lista; var A:Arbol);
var
  min:Camion2;{REGISTRO VIEJO}
  act:Reg;{REGISTRO-NUEVO}
begin
  BuscarMinimo(VL,min);
  while(min.Navenida <> 999)do begin
      act.av:=min.Navenida;
      act.total:=0;
      while(min.Navenida <> 999) and (act.av = min.Navenida)do begin
          act.total:=act.total + min.cantObj;
          BuscarMinimo(VL,min);
      end;
      Insertar(A,act);
  end;
end;

{--FIN--}



{--Programa Principal--}
var
  VL:Vec_Lista;
  A:Arbol;
begin
  {CARGAMOS EL VECTOR DE LISTAS}
  Carg_VL(vl);

  {CARGAMOS MERGE}
  A:=Nil;
  MergeAcumulador(vl,A);

  readln();
end.
