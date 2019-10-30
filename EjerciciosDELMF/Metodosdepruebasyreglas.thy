(*<*) 
theory Metodosdepruebasyreglas
imports Main "HOL-Library.LaTeXsugar" "HOL-Library.OptionalSugar" 
begin
(*>*) 

section \<open>Métodos de pruebas y reglas \<close>

text \<open> Métodos de pruebas de demostraciones:

 \begin{itemize}
  \item[] @{thm[mode=Proof] nat.induct[no_vars]} \hfill (@{text nat.induct})
  \end{itemize}

 \begin{itemize}
  \item[] @{thm[mode=Proof] iffI[no_vars]} \hfill (@{text iffI})
  \end{itemize}

 \begin{itemize}
  \item[] @{thm[mode=Proof] finite.induct[no_vars]} \hfill (@{text finite.induct})
  \end{itemize}

 \begin{itemize}
  \item[] @{thm[mode=Proof] notI[no_vars]} \hfill (@{text notI})
  \end{itemize}


Reglas usadas:

 \begin{itemize}
  \item[] @{thm[mode=Rule] inj_on_def[no_vars]} \hfill (@{text
 inj_on_def})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] ordering_top.extremum[no_vars]} \hfill
 (@{text ordering_top.extremum})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] fun_eq_iff[no_vars]} \hfill (@{text fun_eq_iff})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] o_apply[no_vars]} \hfill (@{text o_apply})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] iffI[no_vars]} \hfill (@{text iffI})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] insert[no_vars]} \hfill (@{text insert})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] exE[no_vars]} \hfill (@{text exE})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] allE[no_vars]} \hfill (@{text allE})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Rule] notI[no_vars]} \hfill (@{text notI})
  \end{itemize}
 \begin{itemize}
  \item[] @{thm[mode=Proof] cases_simp[no_vars]} \hfill (@{text cases})
  \end{itemize}
\<close>


(*<*)
end
(*>*)