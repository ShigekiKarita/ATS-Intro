######
#
# インストール環境によっては以下のように読みかえる必要があります:
#
# atscc -> patscc
# atsopt -> patsopt
# ATSHOME -> PATSHOME
#
######

ATSHOMEQ="$(PATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/patscc
ATSOPT=$(ATSHOMEQ)/bin/patsopt

######

#
# HX: いずれかの行のコメントを外してください。もしくは読み飛ばすこともできます。
#
#ATSCCFLAGS=
#ATSCCFLAGS=-O2
#
# '-flto' はリンク時最適化を有効にします。ライブラリ関数のインライン展開などを行ないます。
#
ATSCCFLAGS=-O2 -flto
#

######

all: foo.out

cleanall::

######

#
# 次の3行のコメントを外してください。
# さらに [foo] という名前をあなたがコンパイルしたい名前に変更してください。
#

%.out: %.dats
	$(ATSCC) $(ATSCCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
cleanall:: ; $(RMF) *.out

######

#
# もしかすると、これらのルールも役に立つかもしれません。
#

%_sats.o: %.sats ; $(ATSCC) $(ATSCCFLAGS) -c $< || echo $@ ": ERROR!!!"
%_dats.o: %.dats ; $(ATSCC) $(ATSCCFLAGS) -c $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
