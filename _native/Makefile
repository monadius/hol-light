HOL_DIR=..

CAMLP5_PATH=
CAMLP5=camlp5r pa_lexer.cmo pa_extend.cmo q_MLast.cmo -I $(HOL_DIR) pa_j.cmo

OPT_ML=ocamlopt -c -pp "$(CAMLP5_PATH)$(CAMLP5)"
OPT_MLI=$(OPT_ML)
OPT_HL=ocamlopt -c -pp "$(CAMLP5_PATH)$(CAMLP5) -impl"
OPTIONS=

DIRS=$(HOL_DIR) $(HOL_DIR)/Library $(HOL_DIR)/Multivariate tame

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
	firstorder.ml \
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

MULTIVARIATE_SRC0=\
	Library/wo.ml \
	Library/card.ml \
	Library/floor.ml \
	Multivariate/misc.ml \
	Multivariate/vectors.ml \
	Library/products.ml \
	Library/permutations.ml \
	Multivariate/determinants.ml \
	Library/iter.ml \
	Multivariate/metric.ml \
	Multivariate/topology.ml \
	Multivariate/convex.ml \
	Library/frag.ml \
	Library/grouptheory.ml \
	Multivariate/homology.ml \
	Multivariate/paths.ml \
	Multivariate/polytope.ml \
	Multivariate/degree.ml \
	Multivariate/derivatives.ml \
	Multivariate/integration.ml \
	Multivariate/measure.ml \
	Multivariate/complexes.ml \
	Multivariate/canal.ml \
	Multivariate/transcendentals.ml \
	Library/binomial.ml \
	Multivariate/realanalysis.ml \
	Multivariate/geom.ml \
	Multivariate/cross.ml \
	Multivariate/flyspeck.ml

TEST_TAME_SRC=\
	tame/arith_options.hl \
	tame/tame_options.hl \
	tame/misc_functions.hl \
	tame/misc_vars.hl \
	tame/nat_arith.hl \
	tame/eval_support.hl \
	tame/test_common.hl \
	tame/tame_defs.hl \
	tame/tame_defs_unrolled.hl \
	tame/tame_support.hl \
	tame/out.hl \
	tame/main.hl

HOL_CORE_SRC=$(addprefix $(HOL_DIR)/,$(HOL_CORE_SRC0))
MULTIVARIATE_SRC=$(addprefix $(HOL_DIR)/,$(MULTIVARIATE_SRC0))

HOL_CORE_OBJ=$(HOL_CORE_SRC:.ml=.cmx)
MULTIVARIATE_OBJ=$(MULTIVARIATE_SRC:.ml=.cmx)
TEST_TAME_OBJ=$(TEST_TAME_SRC:.hl=.cmx)

%.cmi : %.mli
	$(OPT_MLI) $(OPTIONS) $(INCLUDE) $^

%.cmx : %.hl
	$(OPT_HL) $(OPTIONS) $(INCLUDE) -impl $^

%.cmx : %.ml
	$(OPT_ML) $(OPTIONS) $(INCLUDE) $^

.PHONY: hol-core hol-mult parser clean all profile

all: core

parser:
	ocamlc -c -pp "camlp5r pa_lexer.cmo pa_extend.cmo q_MLast.cmo" -I `camlp5 -where` $(HOL_DIR)/pa_j.ml

hol-core: $(HOL_CORE_OBJ)
	@echo "HOL Light core compiled"

hol-mult: $(HOL_CORE_OBJ) $(MULTIVARIATE_OBJ)
	@echo "HOL Light Multivariate library compiled"

core: $(HOL_CORE_OBJ)
	ocamlopt -linkall -o core_test unix.cmxa nums.cmxa $(OPTIONS) $(INCLUDE) $(HOL_CORE_OBJ)

mult: hol-core hol-mult
	ocamlopt -linkall -o mult_test unix.cmxa nums.cmxa $(OPTIONS) $(INCLUDE) $(HOL_CORE_OBJ) $(MULTIVARIATE_OBJ)

profile: OPTIONS=-p

profile: $(HOL_CORE_OBJ)
	ocamlopt -linkall -o core_test unix.cmxa nums.cmxa $(OPTIONS) $(INCLUDE) $(HOL_CORE_OBJ)

# spacetime: CAMLP5_PATH=~/.opam/4.04.0/bin/

spacetime: $(HOL_CORE_OBJ)
	ocamlopt -linkall -o core_spacetime unix.cmxa nums.cmxa $(OPTIONS) $(INCLUDE) $(HOL_CORE_OBJ)


#tame_test: OPTIONS=-p

tame: $(HOL_CORE_OBJ) $(TEST_TAME_OBJ)
	ocamlopt -linkall -o tame_test unix.cmxa nums.cmxa $(OPTIONS) $(INCLUDE) \
		$(HOL_CORE_OBJ) $(TEST_TAME_OBJ)

clean:
	find $(HOL_DIR) -name "*.cmi" -delete \
				-o -name "*.cmx" -delete \
				-o -name "*.o" -delete

clean-tame:
	find tame -name "*.cmi" -delete \
				-o -name "*.cmx" -delete \
				-o -name "*.o" -delete

graph:
	gprof2dot -z camlHol_core__MY_TEST_8830 profile.txt | dot -Tpng -o output.png

gperf:
	gperf ./tame_test gmon.out > profile.txt

valgrind:
	valgrind --tool=callgrind -v --dump-before=KonqMainWindow::slotReload ./tame_test
	kcachegrind