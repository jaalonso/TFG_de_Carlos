(* Teorema de Cantor *)

(*<*) 
theory TeoremaCantor
imports Main "HOL-Library.LaTeXsugar" "HOL-Library.OptionalSugar" 
begin
(*>*) 

text \<open>\comentario{Estructurar en secciones.}\<close>

text \<open>\comentario{Hacer demostraciones detalladas.}\<close>

text \<open>\comentario{Añadir lemas usados al Soporte.}\<close>

section \<open>Demostración en lenguaje natural \<close>

text \<open> El siguiente, denominado  teorema de Cantor por el matemático
 Georg Cantor, es un resultado importante de la teoría
 de conjuntos. 

El matemático Georg Ferdinand Ludwig Philipp Cantor fue un matemático y
lógico nacido en Rusia en el siglo XIX. Fue inventor junto con Dedekind
 y Frege de la teoría de conjuntos, que es la base de las matemáticas
 modernas.


Para la comprensión del teorema vamos a definir una serie de conceptos:

\begin {itemize}

\item Conjunto de potencia $A$  $(\mathcal{P}(A))$: conjunto formado por
todos los subconjuntos de $A$.

\item Cardinal del conjunto $A$ (Denotado $\# A$): número de elementos 
del propio  conjunto.

\end {itemize}
El enunciado original del teorema es el siguiente : 


\begin {teorema}
El cardinal del conjunto potencia de cualquier conjunto A es
 estrictamente mayor que el cardinal de A, o lo que es lo mismo,
$\# \mathcal{P}(A) > \# A.$


\end {teorema}
Pero el enunciado del teorema lo podemos reformular como: 
\begin{teorema}
Dado un conjunto $A$, $\nexists  f : A \longrightarrow \mathcal{P}(A)$ 
que sea sobreyectiva.

\end{teorema}

El teorema se puede reescribir de la anterior forma, ya que si
 se supone que $\exists f$ tal que $f: A \longrightarrow \mathcal{P}(A)$
es sobreyectiva, entonces tenemos que $f(A) = \mathcal{P}(A)$ y por lo
 tanto, $\# f(A) \geq \# \mathcal{P}(A)$, de lo que se deduce esta
 reformulación. Recíprocamente, es trivial ver que esta reformulación
 implica la primera del teorema. 


\begin{demostracion}

La prueba se va a realizar por reducción al absurdo.

Supongamos que $\exists f : A \longrightarrow \mathcal{P}(A)$
 sobreyectiva, es decir, $\forall B \in \mathcal{P}(A) ,  \exists x \in
 A$ tal que $B = f(x)$.

En particular, tomemos el conjunto
 $$B = \{ x \in A : x \notin f(x) \}$$

 y  supongamos que $\exists a \in A : B = f(a)$, ya que $B$ es un
 subconjunto de A. Luego podemos distinguir dos casos :

$1.$ Si $a \in B.$

 Entonces por definición del conjunto $B$ se tiene que
$a \notin B$, luego se llega a una contradicción. 

$2.$ Si $a \notin B.$
 Entonces por definición de B se tiene que $a \in 
B$, luego se ha llegado a otra contradicción. 

En los dos casos se ha llegado a una contradicción,por lo que no existe
 $a$ y $f$ no es sobreyectiva.
\end{demostracion} 

\<close>

section \<open>Especificación en Isabelle/HOL\<close>

text \<open>
Para la especificación del teorema en Isabelle, primero debemos notar
 que $$f :: \, 'a \Rightarrow \,'a \: set$$ significa que es una función 
de tipos, donde $'a$ significa un tipo y para poder denotar
el conjunto potencia tenemos que poner $'a \ set$ que significa que es
 de un tipo formado por conjuntos del tipo $'a$.


El enunciado del teorema es el siguiente : 
\<close>
theorem Cantor: "\<nexists>f :: 'a \<Rightarrow> 'a set. \<forall>A. \<exists>x. A = f x"


  oops 

  text \<open> La demostración la haremos por la regla la introducción a la
negación, la cual es una simplificación de la regla de 
reducción al absurdo, cuyo esquema mostramos a continuación:   
 \begin{itemize}
  \item[] @{thm[mode=Proof] notI[no_vars]} \hfill (@{text notI})
  \end{itemize}



A continuación presentaremos diferentes formas de demostración del
 teorema. \<close>

  section \<open>Demostración detallada \<close>


  text \<open>La primera es la demostración detallada del teorema: \<close>


theorem CantorDetallada: "\<nexists>f :: 'a \<Rightarrow> 'a set. \<forall>B. \<exists>x. B = f x"
proof (rule notI)
  assume "\<exists>f :: 'a \<Rightarrow> 'a set. \<forall>A. \<exists>x. A = f x"
  then obtain f :: "'a \<Rightarrow> 'a set" where *: "\<forall>A. \<exists>x. A = f x" by (rule
        exE)
  let ?B = "{x. x \<notin> f x}"
  from * obtain " \<exists>x. ?B = f x " by (rule allE)
  then  obtain a where 1:"?B = f a" by (rule exE)
  show False
  proof (cases)
    assume "a \<in> ?B"  
    then show False  using 1 by blast
  next 
    assume "a \<notin> ?B"
    thus False using 1 by blast
  qed
qed

section \<open>Demostración aplicativa \<close>


text \<open> La demostración aplicativa del teorema es:\<close>


theorem CantorAplicativa :
 "\<nexists>f :: 'a \<Rightarrow> 'a set. \<forall>A. \<exists>x. A = f x"
  apply (rule notI)
  apply (erule exE)
  apply (erule_tac x = "{x. x \<notin> f x}" in allE)
  apply (erule exE)
  apply  blast 
  done

section \<open>Demostración autmática \<close>

text \<open> La demostración automática del teorema es: \<close>


theorem CantorAutomatic: "\<nexists>f :: 'a \<Rightarrow> 'a set. \<forall>B. \<exists>x. B = f x"
  by best

text \<open>En la demostración de isabelle hemos utilizado el método de prueba
rule con las siguientes reglas, tanto en la aplicativa como en la
 detallada:
 \begin{itemize}
  \item[] @{thm[mode=Rule] notI[no_vars]} \hfill (@{text notI})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] exE[no_vars]} \hfill (@{text exE})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] allE[no_vars]} \hfill (@{text allE})
  \end{itemize}
También hacemos uso de blast, que es un conjunto de reglas lógicas y 
 la demostración automática la hacemos por medio de "best".
\<close>
(*<*) end (*>*)
 