# CSEN 79
# Lab 9 Makefile

STD      = -std=c++20
OPT    	 = -g
CXXFLAGS = ${STD} ${OPT}
CFLAGS   = ${OPT}
TARFLAGS = --no-mac-metadata

# Pattern rules
%: %.cpp
	$(CXX) -o $@ $(CXXFLAGS) $<

%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) $<

# Sources and targets for this lab
SRCS = bagexam.cpp bagtest.cpp
OBJS = $(SRCS:.cpp=.o)
ALL  = bagexam bagtest

all: $(ALL)

bagexam: bagexam.o
	$(CXX) -o $@ $(CXXFLAGS) $+

bagtest: bagtest.o
	$(CXX) -o $@ $(CXXFLAGS) $+

clean:
	/bin/rm -f $(OBJS) $(ALL)
	/bin/rm -rf $(ALL:=.dSYM)

depend: $(SRCS)
	TMP=`mktemp -p .`; export TMP; \
	sed -e '/^# DEPENDENTS/,$$d' Makefile > $$TMP; \
	echo '# DEPENDENTS' >> $$TMP; \
	$(CXX) -MM $+ >> $$TMP; \
	/bin/mv -f $$TMP Makefile


# DEPENDENTS
bagexam.o: bagexam.cpp bag_bst.h bintree.h
bagtest.o: bagtest.cpp bag_bst.h bintree.h
