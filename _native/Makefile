HOL_DIR=..

CAMLP5=camlp5r pa_lexer.cmo pa_extend.cmo q_MLast.cmo -I $(HOL_DIR) pa_j.cmo

OPT_ML=ocamlopt -c -pp "$(CAMLP5)"
OPT_MLI=$(OPT_ML)
OPT_HL=ocamlopt -c -pp "$(CAMLP5) -impl"

DIRS=$(HOL_DIR)

INCLUDE=$(addprefix -I ,$(DIRS))

HOL_CORE_SRC0=\
	system.ml \
	lib.ml \
	fusion.ml \
	basics.ml \
	nets.ml \
	printer.ml \
	preterm.ml \
	parser.ml \
	equal.ml \
	bool.ml \
	drule.ml \
	tactics.ml \
	itab.ml \
	simp.ml \
	theorems.ml \
	ind_defs.ml \
	class.ml \
	trivia.ml \
	canon.ml \
	meson.ml \
	metis.ml \
	quot.ml \
	impconv.ml \
	pair.ml \
	nums.ml \
	recursion.ml \
	arith.ml \
	wf.ml \
	calc_num.ml \
	normalizer.ml \
	grobner.ml \
	ind_types.ml \
	lists.ml \
	realax.ml \
	calc_int.ml \
	realarith.ml \
	real.ml \
	calc_rat.ml \
	int.ml \
	sets.ml \
	iterate.ml \
	cart.ml \
	define.ml \
	hol_core.ml

HOL_CORE_SRC=$(addprefix $(HOL_DIR)/,$(HOL_CORE_SRC0))

HOL_CORE_OBJ=$(HOL_CORE_SRC:.ml=.cmx)

%.cmi : %.mli
	$(OPT_MLI) $(INCLUDE) $^

%.cmx : %.hl
	$(OPT_HL) $(INCLUDE) -impl $^

%.cmx : %.ml
	$(OPT_ML) $(INCLUDE) $^

.PHONY: hol-core parser clean all

all: core

parser:
	ocamlc -c -pp "camlp5r pa_lexer.cmo pa_extend.cmo q_MLast.cmo" -I `camlp5 -where` $(HOL_DIR)/pa_j.ml

hol-core: $(HOL_CORE_OBJ)
	@echo "HOL Light core compiled"

core: $(HOL_CORE_OBJ)
	ocamlopt -linkall -o core unix.cmxa nums.cmxa $(INCLUDE) $(HOL_CORE_OBJ)

clean:
	find $(HOL_DIR) -name "*.cmi" -delete \
				-o -name "*.cmx" -delete \
				-o -name "*.o" -delete
