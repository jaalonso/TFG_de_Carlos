(* Cancelación de funciones inyectivas *)

(*<*) 
theory CancelacionInyectiva
imports Main "HOL-Library.LaTeXsugar" "HOL-Library.OptionalSugar" 
begin
(*>*) 


section \<open>Demostración en lenguaje natural \<close>


text \<open>\comentario{Estructurar en secciones.}\<close>

text \<open>\comentario{Hacer demostraciones detalladas.}\<close>

text \<open>\comentario{Añadir lemas usados al Soporte.}\<close>

text \<open>El siguiente teorema que se va a probar es una caracterización de
 las funciones inyectivas. Primero se definirá el significado de
 inyectividad de una función y la propiedad de ser cancelativa por la
 izquierda. \\
 Una función $f : B \longrightarrow C$ es inyectiva si 
$$\forall x,y \in \ B : f(x) = f(y) \Longrightarrow x =
 y.$$
Una función $f : B \longrightarrow C$ es cancelativa por la izquierda si 
$$\forall A: (\forall g,h: X \longrightarrow Y) : f \circ g = f \circ h
 \Longrightarrow g = h.$$

Luego el teorema es el siguiente:

Luego el teorema es el siguiente:
  
  \begin{teorema}
  $f$ es una función inyectiva, si y solo si, para todas funciones 
 $g$ y $h$  tales que  $f \circ g = f \circ h$ se tiene que $g = h$. 
  \end{teorema}

Vamos a hacer dos lemas de nuestro teorema, ya que se  descompone la
doble implicación en dos implicaciones y se va a  demostrar cada una de
 ellas por  separado.

\begin{lema}[Condición necesaria]
 Si $f$ es una función inyectiva entonces para todas funciones $g$ y $h$
 tales que  $f \circ g = f \circ h$ se tiene que $g = h.$
\end {lema}
  \begin{demostracion}
Por hipótesis se tiene que $f \circ g = f \circ h$, hay que probar que
$g = h$. Usando que f es inyectiva tenemos que: \\
$$(f \circ g)(x) = (f \circ h)(x) \Longrightarrow f(g(x)) = f(h(x)) = 
g(x) = h(x)$$
  \end{demostracion}

\begin {lema}[Condición suficiente] 
Si para toda $g$ y $h$ tales que $f \circ g =  f \circ h$ se tiene que $g
= h$ entonces f es inyectiva.
\end {lema} 

\begin {demostracion}
Si el dominio de la función $f$ fuese vacío, f  es inyectiva.
Supongamos que el dominio de la función $f$ es distinto del vacío y que 
f verifica la propiedad de ser cancelativa por la izquierda.
Hay que demostrar que $\forall a,b$ tales que $f(a) = f(b),$ esto
 implica que $a = b.$ \\
Sean $a,b$ tales que $f(a) = f(b)$. \\
Definiendo  $g(x) = a  \ \forall x$  y $h(x) = b \  \forall x$ entonces 
$$(f \circ g) = (f \circ h) \Longrightarrow  f(g(x)) = f(h(x))
 \Longrightarrow f(a) = f(b)$$

Por hipótesis, entonces $a = b,$ como se quería demostrar.
\end {demostracion} \<close>

section \<open>Especificación en Isabelle/Hol\<close>

text\<open>
  Su especificación es la siguiente, pero al igual que se ha  hecho en
 la demostración a mano se va a demostrar a través de dos lemas:

\<close>
theorem caracterizacion_funcion_inyecctiva:
  "inj f \<longleftrightarrow> (\<forall>g h. (f \<circ> g = f \<circ> h) \<longrightarrow> (g = h))"
  oops



  text \<open>Sus lemas asociados a cada implicación son los siguientes: \<close>

lemma 
"\<forall>g h. (f \<circ> g = f \<circ> h \<longrightarrow> g = h) \<Longrightarrow> inj f"
  oops

lemma 
"inj f \<Longrightarrow> (\<forall>g h.(f \<circ> g = f \<circ> h) \<longrightarrow> (g = h))"
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

  Presentaremos distintas demostraciones de los lemas. \<close>

section \<open>Demostración aplicativa lemas\<close>

text \<open> Las demostraciones aplicativas de los lemas son  :\<close>

lemma condicion_necesaria_aplicativa:
  "inj f \<Longrightarrow> (\<forall>g h.(f \<circ> g = f \<circ> h) \<longrightarrow>  (g = h))"
  apply (simp add: inj_on_def fun_eq_iff) 
  done 

lemma condicion_suficiente_aplicativa:
"\<forall>g h. (f \<circ> g = f \<circ> h \<longrightarrow> g = h) \<Longrightarrow> inj f"
  apply (rule injI)
  by (metis fun_upd_apply fun_upd_comp)


text \<open>En las demostraciones anteriores se han usado los siguientes
 lemas:
  \begin{itemize}
    \item[] @{thm[mode=Rule] fun_eq_iff[no_vars]} 
      \hfill (@{text fun_eq_iff})
  \end{itemize} 
  \begin{itemize}
    \item[] @{thm[mode=Rule] fun_upd_apply[no_vars]} 
      \hfill (@{text fun_upd_apply})
  \end{itemize} 
  \begin{itemize}
    \item[] @{thm[mode=Rule] fun_eq_iff[no_vars]} 
      \hfill (@{text fun_upd_comp})
  \end{itemize}\<close>

section \<open>Demostración estructurada lemas\<close>
 
text \<open>Las demostraciones declarativas son las siguientes: \<close>



lemma condicion_necesaria_detallada:
  assumes "inj f"
  shows "\<forall>g h.(f \<circ> g = f \<circ> h) \<longrightarrow> (g = h)"
proof
  fix g:: "'c \<Rightarrow> 'a"
  show "\<forall>h.(f \<circ> g = f \<circ> h) \<longrightarrow> (g = h)"
  proof (rule allI)
    fix h
    show "f \<circ> g = f \<circ> h \<longrightarrow> (g = h)"
    proof (rule impI)
      assume "f \<circ> g = f \<circ> h"
      show "g = h"
      proof 
        fix x
        have  "(f \<circ> g)(x) = (f \<circ> h)(x)" using `f \<circ> g = f \<circ> h` by simp
        then have "f(g(x)) = f(h(x))" by simp
        thus  "g(x) = h(x)" using `inj f` by (simp add:inj_on_def)
      qed
    qed
  qed
qed

(*<*)declare [[show_types]](*>*)

lemma condicion_suficiente_detallada:
  fixes f :: "'b \<Rightarrow> 'c" 
  assumes "\<forall>(g :: 'a \<Rightarrow> 'b) (h :: 'a \<Rightarrow> 'b).
         (f \<circ> g = f \<circ> h \<longrightarrow> g = h)"
shows " inj f"
proof (rule injI)
  fix a b 
  assume 3: "f a = f b "
  let ?g = "\<lambda>x :: 'a. a"
  let ?h = "\<lambda>x :: 'a. b"
  have "\<forall>(h :: 'a \<Rightarrow> 'b). (f \<circ> ?g = f \<circ> h \<longrightarrow> ?g = h)"
    using assms by (rule allE)
  hence 1: " (f \<circ> ?g = f \<circ> ?h \<longrightarrow> ?g = ?h)"  by (rule allE) 
  have 2: "f \<circ> ?g = f \<circ> ?h" 
  proof 
    fix x
    have " (f \<circ> (\<lambda>x :: 'a. a)) x = f(a) " by simp
    also have "... = f(b)" using 3 by simp
    also have "... =  (f \<circ> (\<lambda>x :: 'a. b)) x" by simp
    finally show " (f \<circ> (\<lambda>x :: 'a. a)) x =  (f \<circ> (\<lambda>x :: 'a. b)) x"
      by simp
  qed
  have "?g = ?h" using 1 2 by (rule mp)
  then show " a = b" by (rule fun_cong)
qed




text \<open>
En la anterior demostración se ha introducito la regla: 
  \begin{itemize}
    \item[] @{thm[mode=Rule] fun_cong[no_vars]} 
      \hfill (@{text fun_cong})
  \end{itemize}
Otras demostraciones declarativas usando auto y blast son:\<close>

lemma condicion_necesaria_detallada1:
  assumes "inj f"
  shows "(f \<circ> g = f \<circ> h) \<longrightarrow>(g = h)"
proof 
  assume "f \<circ> g = f \<circ> h" 
  then show "g = h" using `inj f` by (simp add: inj_on_def fun_eq_iff) 
qed

lemma condicion_suficiente_detallada1:
  fixes f :: "'b \<Rightarrow> 'c" 
  assumes "\<forall>(g :: 'a \<Rightarrow> 'b) (h :: 'a \<Rightarrow> 'b).
         (f \<circ> g = f \<circ> h \<longrightarrow> g = h)"
  shows " inj f"
proof (rule injI)
  fix a b 
  assume 1: "f a = f b "
  let ?g = "\<lambda>x :: 'a. a"
  let ?h = "\<lambda>x :: 'a. b"
  have 2: " (f \<circ> ?g = f \<circ> ?h \<longrightarrow> ?g = ?h)"  using assms by blast
  have 3: "f \<circ> ?g = f \<circ> ?h" 
  proof 
    fix x
    have " (f \<circ> (\<lambda>x :: 'a. a)) x = f(a) " by simp
    also have "... = f(b)" using 1 by simp
    also have "... =  (f \<circ> (\<lambda>x :: 'a. b)) x" by simp
    finally show " (f \<circ> (\<lambda>x :: 'a. a)) x =  (f \<circ> (\<lambda>x :: 'a. b)) x"
      by simp
  qed
  show  " a = b" using 2 3 by meson
qed


section \<open>Demostración teorema en Isabelle/Hol\<close>
text \<open>En consecuencia, la demostración de nuestro teorema: \<close>

theorem caracterizacion_inyectividad:
  "inj f \<longleftrightarrow> (\<forall>g h. (f \<circ> g = f \<circ> h) \<longrightarrow> (g = h))"
  using condicion_necesaria_detallada condicion_suficiente_detallada
  by auto





(*<*)
end
(*>*) 