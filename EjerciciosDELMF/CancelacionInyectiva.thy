(*<*) 
theory CancelacionInyectiva
imports Main "HOL-Library.LaTeXsugar" "HOL-Library.OptionalSugar" 
begin
(*>*) 


section \<open>Cancelación de funciones inyectivas\<close>

text \<open>El siguiente teorema prueba una propiedad de las funciones
  inyectivas estudiado en el \href{http://bit.ly/2XBW6n2}{tema 10} del 
  curso. Su enunciado es el siguiente
  
  \begin{teorema}
    Las funciones inyectivas son cancelativas por la izquierda. Es
    decir, si $f$ es una función inyectiva entonces para todas $g$ y $h$
    tales que @{text "f \<circ> g = f \<circ> h"} se tiene que $g = h$. 
  \end{teorema}

  \begin{demostracion}
    La demostración la haremos por doble implicación: 
\begin {enumerate}
\item Supongamos que tenemos que $f \circ g = f \circ h$, queremos
 demostrar que $g = h$, usando que f es inyectiva tenemos que: \\
$$(f \circ g)(x) = (f \circ h)(x) \Longrightarrow f(g(x)) = f(h(x)) = 
g(x) = h(x)$$
\item Supongamos ahora que $g = h$, queremos demostrar que  $f \circ g
 = f \circ h$. \\
$$(f \circ g)(x) = f(g(x)) = f(h(x)) = (f \circ h)(x)$$
\end {enumerate}
.
  \end{demostracion}

  Su especificación es la siguiente:
\<close>

lemma 
  "inj f \<Longrightarrow> (f \<circ> g = f \<circ> h) = (g = h)"
oops

text \<open>En la especificación anterior, @{term "inj f"} es una 
  abreviatura de @{term "inj_on f UNIV"} definida en la teoría
  \href{http://bit.ly/2XuPQx5}{Fun.thy}. Además, contiene la definición
  de @{term "inj_on"}
  \begin{itemize}
    \item[] @{thm[mode=Rule] inj_on_def[no_vars]} \hfill (@{text inj_on_def})
  \end{itemize} 
  Por su parte, @{term UNIV} es el conjunto universal definido en la 
  teoría \href{http://bit.ly/2XtHCW6}{Set.thy} como una abreviatura de 
  @{term top} que, a su vez está definido en la teoría 
  \href{http://bit.ly/2Xyj9Pe}{Orderings.thy} mediante la siguiente
  propiedad 
  \begin{itemize}
    \item[] @{thm[mode=Rule] ordering_top.extremum[no_vars]} 
      \hfill (@{text ordering_top.extremum})
  \end{itemize} 
  En el caso de la teoría de conjuntos, la relación de orden es la
  inclusión de conjuntos.

  Presentaremos distintas demostraciones del teorema. La primera
  demostración es applicativa\<close> 

lemma 
  "inj f \<Longrightarrow> (f \<circ> g = f \<circ> h) = (g = h)"
  apply (simp add: inj_on_def fun_eq_iff) 
  apply auto
  done

text \<open>En la demostración anterior se ha usado el siguiente lema
  \begin{itemize}
    \item[] @{thm[mode=Rule] fun_eq_iff[no_vars]} 
      \hfill (@{text fun_eq_iff})
  \end{itemize} 

  La demostración applicativa sin auto es\<close>

lemma
  "inj f \<Longrightarrow> (f \<circ> g = f \<circ> h) = (g = h)"
  apply (unfold inj_on_def) 
  apply (unfold fun_eq_iff) 
  apply (unfold o_apply)
  apply (rule iffI)
   apply simp+
  done

text \<open>En la demostración anterior se ha introducido los siguientes
  hechos
  \begin{itemize}
    \item @{thm o_apply[no_vars]} \hfill (@{text o_apply})
    \item @{thm iffI[no_vars]} \hfill (@{text iffI})
  \end{itemize} 

  La demostración automática es\<close>

lemma
  assumes "inj f"
  shows "(f \<circ> g = f \<circ> h) = (g = h)"
  using assms
  by (auto simp add: inj_on_def fun_eq_iff) 

text \<open>La demostración declarativa\<close>

lemma
  assumes "inj f"
  shows "(f \<circ> g = f \<circ> h) = (g = h)"
proof 
  assume "f \<circ> g = f \<circ> h"
  show "g = h"
  proof
    fix x
    have "(f \<circ> g)(x) = (f \<circ> h)(x)" using `f \<circ> g = f \<circ> h` by simp
    then have "f(g(x)) = f(h(x))" by simp
    then show "g(x) = h(x)" using `inj f` by (simp add:inj_on_def)
  qed
next
  assume "g = h"
  show "f \<circ> g = f \<circ> h"
  proof
    fix x
    have "(f \<circ> g) x = f(g(x))" by simp
    also have "\<dots> = f(h(x))" using `g = h` by simp
    also have "\<dots> = (f \<circ> h) x" by simp
    finally show "(f \<circ> g) x = (f \<circ> h) x" by simp
  qed
qed

text \<open>Otra demostración declarativa es\<close>

lemma 
  assumes "inj f"
  shows "(f \<circ> g = f \<circ> h) = (g = h)"
proof 
  assume "f \<circ> g = f \<circ> h" 
  then show "g = h" using `inj f` by (simp add: inj_on_def fun_eq_iff) 
next
  assume "g = h" 
  then show "f \<circ> g = f \<circ> h" by simp
qed

(*<*)
end
(*>*) 