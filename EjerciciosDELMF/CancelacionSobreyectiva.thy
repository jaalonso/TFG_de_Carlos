(*<*) 
theory CancelacionSobreyectiva 
imports Main "HOL-Library.LaTeXsugar" "HOL-Library.OptionalSugar" 
begin
(*>*) 

section \<open>Cancelación de las funciones sobreyectivas\<close>

text \<open>
El siguiente teorema prueba una propiedad de las funciones
 sobreyectivas. El enunciado es el siguiente: 
\begin {teorema}
Las funciones sobreyectivas son cancelativas por la derecha. Es decir,
 si f es sobreyectiva entonces para todas funciones g y h tal que g o f
 = h o f se tiene que g = h.
\end {teorema}
 
\begin {demostracion}
\begin {itemize}
\item Supongamos que tenemos que $g o f = h o f$, queremos probar que $g =
 h.$ Usando la definición de sobreyectividad $(\forall y \in Y,
 \exists x | y = f(x))$ y nuestra hipótesis, tenemos que:
$$g(y) = g(f(x)) = (g o f) (x) = (h o f) (x) = h(f(x)) = h(y)$$
\item Supongamos que $g = h$, hay que probar que $g o f = h o f.$ Usando
nuestra hipótesis, tenemos que:
$$ (g o f)(x) = g(f(x)) = h(f(x)) = (h o f) (x).$$
\end {itemize}
.
\end {demostracion}

Su especificación es la siguiente: 
\<close>

lemma "surj f \<Longrightarrow> ( g \<o> f = h \<o> f ) = (g = h)"
  oops

  text \<open>
En la especificación anterior, @{term "surj f"} es una abreviatura de 
  @{term "range f = UNIV"}, donde @{term "range f"} es el rango o imagen
de la función f.
 Por otra parte, @{term UNIV} es el conjunto universal definido en la 
  teoría \href{http://bit.ly/2XtHCW6}{Set.thy} como una abreviatura de 
  @{term top} que, a su vez está definido en la teoría 
  \href{http://bit.ly/2Xyj9Pe}{Orderings.thy} mediante la siguiente
  propiedad 
  \begin{itemize}
    \item[] @{thm[mode=Rule] ordering_top.extremum[no_vars]} 
      \hfill (@{text ordering_top.extremum})
  \end{itemize} 
Además queda añadir que la teoría donde se encuentra definido @{term"surj f"}
 es en \href{http://bit.ly/2XuPQx5}{Fun.thy}. Esta teoría contiene la
 definicion @{term" surj_def"}.
 \begin{itemize}
    \item[] @{thm[mode=Rule] surj_def[no_vars]} \hfill (@{text inj_on_def})
  \end{itemize} 

Presentaremos distintas demostraciones del teorema. La primera es la
 detallada:
\<close>

lemma 
  assumes "surj f" 
  shows "( g \<circ> f = h \<circ> f ) = (g = h)"
proof (rule iffI)
  assume 1: " g \<circ> f = h \<circ> f "
  show "g = h" 
  proof 
    fix x 
    have " \<exists>y . x = f(y)" using assms by (simp add:surj_def)
    then obtain "y" where 2:"x = f(y)" by (rule exE)
    then have "g(x) = g(f(y))" by simp
    then have "... = (g \<circ> f) (y)  " by simp
    then have "... = (h o f) (y)" using 1 by simp
    then have "... = h(f(y))" by simp
    then have "... = h(x)" using 2   by (simp add: \<open>x = f y\<close>)
    then show " g(x) = h(x) " 
      using \<open>(g \<circ> f) y = (h \<circ> f) y\<close> \<open>(h \<circ> f) y = h (f y)\<close>
    \<open>g (f y) = (g \<circ> f) y\<close> \<open>g x = g (f y)\<close> \<open>h (f y) = h x\<close> by presburger
  qed
next
  assume "g = h" 
  show "g \<circ> f = h \<circ> f"
  proof
    fix x
    have "(g \<circ> f) x = g(f(x))" by simp
    also have "\<dots> = h(f(x))" using `g = h` by simp
    also have "\<dots> = (h \<circ> f) x" by simp
    finally show "(g \<circ> f) x = (h \<circ> f) x" by simp
  qed
qed


text \<open>En la demostración hemos introducido: 
 \begin{itemize}
    \item[] @{thm[mode=Rule] exE[no_vars]} 
      \hfill (@{text "rule exE"}) 
  \end{itemize} 
 \begin{itemize}
    \item[] @{thm[mode=Proof] iffI[no_vars]} 
      \hfill (@{text iffI})
  \end{itemize} 

La demostración aplicativa es: \<close>

lemma "surj f \<Longrightarrow> ((g \<circ> f) = (h \<circ> f) ) = (g = h)"
  apply (simp add: surj_def fun_eq_iff)
  apply  metis
  done

text \<open>En esta demostración hemos introducido:
 \begin{itemize}
    \item[] @{thm[mode=Rule] fun_eq_iff[no_vars]} 
      \hfill (@{text fun_eq_iff})
  \end{itemize} 
\<close>
  
    



 
(*<*)
end 
(*>*)