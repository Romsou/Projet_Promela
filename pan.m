#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC :init: */
	case 3: // STATE 1 - berger.pml:43 - [(run M())] (0:0:0 - 1)
		IfNotBlocked
		reached[5][1] = 1;
		if (!(addproc(II, 1, 2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - berger.pml:43 - [(run C())] (0:0:0 - 1)
		IfNotBlocked
		reached[5][2] = 1;
		if (!(addproc(II, 1, 3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 3 - berger.pml:43 - [(run L())] (0:0:0 - 1)
		IfNotBlocked
		reached[5][3] = 1;
		if (!(addproc(II, 1, 1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 4 - berger.pml:43 - [(run B())] (0:0:0 - 1)
		IfNotBlocked
		reached[5][4] = 1;
		if (!(addproc(II, 1, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 6 - berger.pml:44 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[5][6] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM never_0 */
	case 8: // STATE 1 - berger.pml:35 - [(((((p[0]==1)&&(p[1]==1))&&(p[2]==1))&&(p[3]==1)))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][1] = 1;
		if (!(((((((int)now.p[0])==1)&&(((int)now.p[1])==1))&&(((int)now.p[2])==1))&&(((int)now.p[3])==1))))
			continue;
		/* merge: assert(!(((((p[0]==1)&&(p[1]==1))&&(p[2]==1))&&(p[3]==1))))(0, 2, 6) */
		reached[4][2] = 1;
		spin_assert( !(((((((int)now.p[0])==1)&&(((int)now.p[1])==1))&&(((int)now.p[2])==1))&&(((int)now.p[3])==1))), " !(((((p[0]==1)&&(p[1]==1))&&(p[2]==1))&&(p[3]==1)))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[4][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 9: // STATE 4 - berger.pml:36 - [((((!((p[0]==p[1]))&&!((p[0]==p[2])))&&(p[1]==p[2]))&&(p[2]==p[3])))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported4 = 0;
			if (verbose && !reported4)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported4 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported4 = 0;
			if (verbose && !reported4)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported4 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][4] = 1;
		if (!(((( !((((int)now.p[0])==((int)now.p[1])))&& !((((int)now.p[0])==((int)now.p[2]))))&&(((int)now.p[1])==((int)now.p[2])))&&(((int)now.p[2])==((int)now.p[3])))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 10 - berger.pml:40 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC C */
	case 11: // STATE 1 - berger.pml:28 - [canal?aller] (8:0:1 - 1)
		reached[3][1] = 1;
		if (boq != now.canal) continue;
		if (q_len(now.canal) == 0) continue;

		XX=1;
		if (2 != qrecv(now.canal, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.canal-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.canal, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.canal);
			sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.canal))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		/* merge: p[3] = 1(8, 2, 8) */
		reached[3][2] = 1;
		(trpt+1)->bup.oval = ((int)now.p[3]);
		now.p[3] = 1;
#ifdef VAR_RANGES
		logval("p[3]", ((int)now.p[3]));
#endif
		;
		/* merge: goto right(8, 3, 8) */
		reached[3][3] = 1;
		;
		_m = 4; goto P999; /* 2 */
	case 12: // STATE 5 - berger.pml:29 - [canal?retour] (4:0:1 - 1)
		reached[3][5] = 1;
		if (boq != now.canal) continue;
		if (q_len(now.canal) == 0) continue;

		XX=1;
		if (1 != qrecv(now.canal, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.canal-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.canal, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.canal);
			sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.canal))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		/* merge: p[3] = 0(4, 6, 4) */
		reached[3][6] = 1;
		(trpt+1)->bup.oval = ((int)now.p[3]);
		now.p[3] = 0;
#ifdef VAR_RANGES
		logval("p[3]", ((int)now.p[3]));
#endif
		;
		/* merge: goto left(4, 7, 4) */
		reached[3][7] = 1;
		;
		_m = 4; goto P999; /* 2 */

		 /* PROC M */
	case 13: // STATE 1 - berger.pml:23 - [canal?aller] (8:0:1 - 1)
		reached[2][1] = 1;
		if (boq != now.canal) continue;
		if (q_len(now.canal) == 0) continue;

		XX=1;
		if (2 != qrecv(now.canal, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.canal-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.canal, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.canal);
			sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.canal))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		/* merge: p[2] = 1(8, 2, 8) */
		reached[2][2] = 1;
		(trpt+1)->bup.oval = ((int)now.p[2]);
		now.p[2] = 1;
#ifdef VAR_RANGES
		logval("p[2]", ((int)now.p[2]));
#endif
		;
		/* merge: goto right(8, 3, 8) */
		reached[2][3] = 1;
		;
		_m = 4; goto P999; /* 2 */
	case 14: // STATE 5 - berger.pml:24 - [canal?retour] (4:0:1 - 1)
		reached[2][5] = 1;
		if (boq != now.canal) continue;
		if (q_len(now.canal) == 0) continue;

		XX=1;
		if (1 != qrecv(now.canal, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.canal-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.canal, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.canal);
			sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.canal))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		/* merge: p[2] = 0(4, 6, 4) */
		reached[2][6] = 1;
		(trpt+1)->bup.oval = ((int)now.p[2]);
		now.p[2] = 0;
#ifdef VAR_RANGES
		logval("p[2]", ((int)now.p[2]));
#endif
		;
		/* merge: goto left(4, 7, 4) */
		reached[2][7] = 1;
		;
		_m = 4; goto P999; /* 2 */

		 /* PROC L */
	case 15: // STATE 1 - berger.pml:18 - [canal?aller] (8:0:1 - 1)
		reached[1][1] = 1;
		if (boq != now.canal) continue;
		if (q_len(now.canal) == 0) continue;

		XX=1;
		if (2 != qrecv(now.canal, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.canal-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.canal, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.canal);
			sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.canal))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		/* merge: p[1] = 1(8, 2, 8) */
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.p[1]);
		now.p[1] = 1;
#ifdef VAR_RANGES
		logval("p[1]", ((int)now.p[1]));
#endif
		;
		/* merge: goto right(8, 3, 8) */
		reached[1][3] = 1;
		;
		_m = 4; goto P999; /* 2 */
	case 16: // STATE 5 - berger.pml:19 - [canal?retour] (4:0:1 - 1)
		reached[1][5] = 1;
		if (boq != now.canal) continue;
		if (q_len(now.canal) == 0) continue;

		XX=1;
		if (1 != qrecv(now.canal, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.canal-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.canal, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.canal);
			sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.canal))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		/* merge: p[1] = 0(4, 6, 4) */
		reached[1][6] = 1;
		(trpt+1)->bup.oval = ((int)now.p[1]);
		now.p[1] = 0;
#ifdef VAR_RANGES
		logval("p[1]", ((int)now.p[1]));
#endif
		;
		/* merge: goto left(4, 7, 4) */
		reached[1][7] = 1;
		;
		_m = 4; goto P999; /* 2 */

		 /* PROC B */
	case 17: // STATE 1 - berger.pml:8 - [canal!aller] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (q_len(now.canal))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.canal);
		sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.canal, 0, 2, 1);
		{ boq = now.canal; };
		_m = 2; goto P999; /* 0 */
	case 18: // STATE 2 - berger.pml:8 - [p[0] = 1] (0:17:1 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((int)now.p[0]);
		now.p[0] = 1;
#ifdef VAR_RANGES
		logval("p[0]", ((int)now.p[0]));
#endif
		;
		/* merge: goto right(17, 3, 17) */
		reached[0][3] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 19: // STATE 5 - berger.pml:9 - [p[0] = 1] (0:17:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.p[0]);
		now.p[0] = 1;
#ifdef VAR_RANGES
		logval("p[0]", ((int)now.p[0]));
#endif
		;
		/* merge: goto right(17, 6, 17) */
		reached[0][6] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 20: // STATE 10 - berger.pml:12 - [canal!retour] (0:0:0 - 1)
		IfNotBlocked
		reached[0][10] = 1;
		if (q_len(now.canal))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.canal);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.canal, 0, 1, 1);
		{ boq = now.canal; };
		_m = 2; goto P999; /* 0 */
	case 21: // STATE 11 - berger.pml:12 - [p[0] = 0] (0:8:1 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		(trpt+1)->bup.oval = ((int)now.p[0]);
		now.p[0] = 0;
#ifdef VAR_RANGES
		logval("p[0]", ((int)now.p[0]));
#endif
		;
		/* merge: goto left(8, 12, 8) */
		reached[0][12] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 22: // STATE 14 - berger.pml:13 - [p[0] = 0] (0:8:1 - 1)
		IfNotBlocked
		reached[0][14] = 1;
		(trpt+1)->bup.oval = ((int)now.p[0]);
		now.p[0] = 0;
#ifdef VAR_RANGES
		logval("p[0]", ((int)now.p[0]));
#endif
		;
		/* merge: goto left(8, 15, 8) */
		reached[0][15] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 23: // STATE 19 - berger.pml:15 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][19] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

