(* Cancelación de las funciones sobreyectivas *)

(*<*) 
theory CancelacionSobreyectiva 
imports Main "HOL-Library.LaTeXsugar" "HOL-Library.OptionalSugar" 
begin
(*>*) 

text \<open>\comentario{Estructurar en secciones.}\<close>

text \<open>\comentario{Hacer demostraciones detalladas.}\<close>

text \<open>\comentario{Añadir lemas usados al Soporte.}\<close>

section \<open>Demostración en Lenguaje natural \<close>
text \<open>
El siguiente teorema prueba una caracterización de las funciones
 sobreyectivas. Primero se definirá el significado de la sobreyectividad
de una función y de la propiedad de ser cancelativa por la derecha. \\
Una función $f : A \longrightarrow B$ es sobreyectiva si 
$$\forall y \in B : \exists x \in A : f(x) = y$$
Una función $f : A \longrightarrow B$ tiene la propiedad de ser
 canletiva por la izquierda si: 
$$\forall C : (\forall g,h: B \longrightarrow C) : g \circ f = h \circ f
\Longrightarrow g = h$$

Luego el teorema es el siguiente: 

\begin {teorema}
  f es sobreyectiva si y solo si  para todas funciones g y h tal que 
$g \circ f  = h \circ f$ se tiene que g = h.
\end {teorema}
 
El teorema se puede dividir en dos lemas, ya que  se
 demuestra por una doble implicación.

\begin {lema}[Condición necesaria]
 Si $f$ es sobreyectiva entonces  para todas funciones g y h tal que 
$g \circ f = h \circ f$ se tiene que $g = h$.
\end {lema}

\begin {demostracion}
Supongamos que tenemos que $g \circ  f = h \circ f$, queremos
 probar que $g = h.$ Usando la definición de sobreyectividad
 $(\forall y \in Y,  \exists x \| y = f(x))$ y nuestra hipótesis,
 tenemos que: $$g(y) = g(f(x)) = (g \circ f) (x) = (h \circ f) (x) =
 h(f(x)) = h(y).$$
\end {demostracion}

\begin {lema}[Condición necesaria] 
 Si  para todas funciones g y h tal que $g \circ f  = h \circ f$ se 
tiene que g = h entonces f es sobreyectiva.
\end {lema}

\begin {demostracion}
Para la demostración del lema, primero se debe señalar los
 dominios y codominios de las funciones que se van a usar.
 $f : C \longrightarrow A,$ $g,h: A \longrightarrow B.$ También se debe
 notar que el conjunto  $B$ tiene que tener almenos dos elementos
 diferentes,luego supongamos que $B = \{a,b\}.$ \\
La prueba se va a realizar por reducción al absurdo. Luego supongamos
que nuestra función $f$ no es sobreyectiva, es decir, $\exists y_{1} \in
 A \ @{text " tal que "} \  \nexists x \in C \ : f(x) = y.$ \\
Definamos ahora las funciones $g,h:$
$$g(y) = a \  \forall y \in A$$


$$h(y)= \left\{ \begin{array}{lcc}
             a &   si  & y \neq y_1 \\
             b &  si & y = y_1
             \end{array}
   \right.$$


Entonces $g(y) \neq h(y).$ Sin embargo,
 por hipótesis se tiene  que si $g \circ f = h \circ f$, lo cual es
 cierto, entonces $h = g.$ Por lo que hemos llegado a una
 contradicción, por lo tanto, $f$ es sobreyectiva.
\end {demostracion} 
\<close>
section \<open>Especificación en Isabelle/Hol \<close>

text \<open>
Su especificación es la siguiente, que se dividira en dos al igual que 
en la demostración a mano: \<close>

theorem caracterizacion_funciones_sobreyectivas:
 "surj f \<longleftrightarrow> (\<forall>g h.(g \<circ> f = h \<circ> f) \<longrightarrow> (g = h))"
  oops

lemma condicion_suficiente:
"surj f \<Longrightarrow>  (\<forall>g h. (g \<circ> f = h \<circ> f) \<longrightarrow> (g = h))"
  oops

lemma condicion_necesaria:
"\<forall>g h. (g \<circ> f = h \<circ> f \<longrightarrow> g = h) \<longrightarrow> surj f"
  oops


  text \<open>
En la especificación anterior, @{term "surj f"} es una abreviatura de 
  @{text "range f = UNIV"}, donde @{term "range f"} es el rango o imagen
de la función f y @{term UNIV} es el conjunto universal definido en la 
  teoría \href{http://bit.ly/2XtHCW6}{Set.thy} como una abreviatura de 
  @{term top} que, a su vez está definido en la teoría 
  \href{http://bit.ly/2Xyj9Pe}{Orderings.thy} mediante la siguiente
  propiedad 
  \begin{itemize}
    \item[] @{thm[mode=Rule] ordering_top.extremum[no_vars]} 
      \hfill (@{text ordering_top.extremum})
  \end{itemize} 
Además queda añadir que la teoría donde se encuentra definido
 @{term"surj f"} es en \href{http://bit.ly/2XuPQx5}{Fun.thy}. Esta
 teoría contiene la definicion @{term" surj_def"}.
 \begin{itemize}
    \item[] @{thm[mode=Rule] surj_def[no_vars]}
 \hfill (@{text surj__def})
  \end{itemize} 

\<close>

section \<open>Demostración estructurada \<close>

text \<open>
Presentaremos distintas demostraciones de los lemas. Las primeras son
 las detalladas:
\<close>


lemma condicion_suficiente_detallada:
  assumes "surj f" 
  shows "\<forall>g h. ( g \<circ> f = h \<circ> f ) \<longrightarrow> (g = h)"
proof (rule allI)
  fix g :: "'a \<Rightarrow>'c" 
  show "\<forall>h. (g \<circ> f = h \<circ> f) \<longrightarrow> (g = h)"
  proof (rule allI)
    fix h
    show "(g \<circ> f = h \<circ> f) \<longrightarrow> (g = h)" 
    proof (rule impI)
      assume 1: "g \<circ> f = h \<circ> f"
      show "g = h"
      proof  
        fix x
        have " \<exists>y . x = f(y)" using assms by (simp add:surj_def)
        then obtain  "y" where 2:"x = f(y)" by (rule exE)
        then have  "g(x) = g(f(y))" by simp
        also have  "... = (g \<circ> f) (y)  " by simp
        also have  "... = (h \<circ> f) (y)" using 1 by simp
        also have  "... = h(f(y))" by simp
        also have  "... = h(x)" using 2   by (simp add: \<open>x = f y\<close>)
        finally show  " g(x) = h(x) " by simp
      qed
    qed
  qed
qed


text \<open> En la siguiente demostración nos hará falta la introducción de
 los pequeños lemas que demostraremos a continuación: \<close>


lemma auxiliar_1:
  assumes "\<not>(\<forall>x. P(x))"
  shows   "\<exists>x. \<not>P(x)"
using assms
  by auto

lemma auxiliar_2:
  assumes "\<not>(\<exists>x. P(x))"
  shows   "\<forall>x. \<not>P(x)"
using assms
by auto

lemma condicion_necesaria_detallada:
  assumes "\<forall>(g :: 'b \<Rightarrow> 'c) h .(g \<circ> (f :: 'a \<Rightarrow> 'b) = h \<circ> f) \<longrightarrow> (g = h)"
           "\<exists> (x0::'c) (x1::'c). x0 \<noteq> x1"
         shows " \<forall> (y::'b). (\<exists> (x:: 'a). f x = y)"
proof (rule ccontr)
  assume "\<not> (\<forall>y :: 'b. \<exists>x :: 'a. f x = y)"
  hence "\<exists>y :: 'b . \<not> (\<exists>x :: 'a. f x = y)" by (rule auxiliar_1)
  then obtain y0 where  "\<not> (\<exists>x :: 'a. f x = y0)" by (rule exE)
  hence "\<forall>x :: 'a. (\<not> (f x = y0))" by (rule auxiliar_2)
  obtain a0 where " \<exists>(x1::'c). a0 \<noteq> x1" using assms(2) by (rule exE)
  then obtain a1 where "a0 \<noteq> a1" by (rule exE)
  let ?g = "(\<lambda>x. a0)  :: 'b \<Rightarrow> 'c"
  let ?h = "?g(y0:=a1)"
  have "\<forall>h .(?g \<circ> (f :: 'a \<Rightarrow> 'b) = h \<circ> f) \<longrightarrow> (?g = h)"
    using assms(1) by (rule allE)
  hence 1:"(?g \<circ> (f :: 'a \<Rightarrow> 'b) = ?h \<circ> f) \<longrightarrow> (?g = ?h)" by (rule allE)
  have 2: "(?g \<circ> (f :: 'a \<Rightarrow> 'b) = ?h \<circ> f)"
    using [[simp_trace]]
    using \<open>\<nexists>x :: 'a. (f :: 'a \<Rightarrow> 'b) x = (y0 :: 'b)\<close> by auto
  have "(?g = ?h)" using 1 2 by (rule mp)
  hence "a0 = a1" by (metis fun_upd_idem_iff)
  with `a0 \<noteq> a1` show False by (rule notE)
qed

lemma condicion_necesaria_detallada_2:
  assumes " \<forall> (y::'b). (\<exists> (x:: 'a). f x = y)"
  shows "surj f"
  by (metis assms surj_def)
    
text \<open>En la demostración hemos introducido: 
 \begin{itemize}
    \item[] @{thm[mode=Rule] exE[no_vars]} 
      \hfill (@{text "rule exE"}) 
  \end{itemize} 
 \begin{itemize}
    \item[] @{thm[mode=Proof] iffI[no_vars]} 
      \hfill (@{text iffI})
  \end{itemize} 
\<close>

section \<open>Demostración aplicativa \<close>

text \<open>Las demostraciones aplicativas son: \<close>

lemma demostracion_suficiente_aplicativa:
"surj f \<Longrightarrow> ((g \<circ> f) = (h \<circ> f) ) \<longrightarrow> (g = h)"
  apply (simp add: surj_def fun_eq_iff)
  apply metis
  done

lemma demostracion_necesaria_aplicativa:
  "\<lbrakk>\<forall>(g :: 'b \<Rightarrow> 'c) h .(g \<circ> (f :: 'a \<Rightarrow> 'b) = h \<circ> f) \<longrightarrow> (g = h);
          \<exists> (x0::'c) (x1::'c). x0 \<noteq> x1\<rbrakk>\<Longrightarrow> surj f"
  apply (rule surjI)
  apply (drule condicion_necesaria_detallada)
   apply simp
  apply (erule allE)
  apply (erule exE)+
  apply (erule Hilbert_Choice.someI)
  done

text \<open>
En estas hemos introducido:
 \begin{itemize}
    \item[] @{thm[mode=Rule] fun_eq_iff[no_vars]} 
      \hfill (@{text fun_eq_iff})
     \item[] @{thm[mode=Rule] Hilbert_Choice.someI[no_vars]} 
      \hfill (@{text Hilbert_Choice.someI})
\end{itemize}
\<close>
section \<open>Demostración teorema \<close>
text \<open>En consecuencia, la demostración del teorema es \<close>

theorem caracterizacion_funciones_sobreyectivas:
 "surj f \<longleftrightarrow>  (\<forall>g h.(g \<circ> f = h \<circ> f) \<longrightarrow> (g = h))"
  oops
  

(*<*)
end 
(*>*)