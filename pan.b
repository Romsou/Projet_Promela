	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */

	case 3: // STATE 1
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 4: // STATE 2
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 5: // STATE 3
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 6: // STATE 4
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 7: // STATE 6
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM never_0 */
;
		
	case 8: // STATE 1
		goto R999;
;
		;
		
	case 10: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC C */

	case 11: // STATE 2
		;
		now.p[3] = trpt->bup.oval;
		XX = 1;
		unrecv(now.canal, XX-1, 0, 2, 1);
		;
		;
		goto R999;

	case 12: // STATE 6
		;
		now.p[3] = trpt->bup.oval;
		XX = 1;
		unrecv(now.canal, XX-1, 0, 1, 1);
		;
		;
		goto R999;

		 /* PROC M */

	case 13: // STATE 2
		;
		now.p[2] = trpt->bup.oval;
		XX = 1;
		unrecv(now.canal, XX-1, 0, 2, 1);
		;
		;
		goto R999;

	case 14: // STATE 6
		;
		now.p[2] = trpt->bup.oval;
		XX = 1;
		unrecv(now.canal, XX-1, 0, 1, 1);
		;
		;
		goto R999;

		 /* PROC L */

	case 15: // STATE 2
		;
		now.p[1] = trpt->bup.oval;
		XX = 1;
		unrecv(now.canal, XX-1, 0, 2, 1);
		;
		;
		goto R999;

	case 16: // STATE 6
		;
		now.p[1] = trpt->bup.oval;
		XX = 1;
		unrecv(now.canal, XX-1, 0, 1, 1);
		;
		;
		goto R999;

		 /* PROC B */

	case 17: // STATE 1
		;
		_m = unsend(now.canal);
		;
		goto R999;

	case 18: // STATE 2
		;
		now.p[0] = trpt->bup.oval;
		;
		goto R999;

	case 19: // STATE 5
		;
		now.p[0] = trpt->bup.oval;
		;
		goto R999;

	case 20: // STATE 10
		;
		_m = unsend(now.canal);
		;
		goto R999;

	case 21: // STATE 11
		;
		now.p[0] = trpt->bup.oval;
		;
		goto R999;

	case 22: // STATE 14
		;
		now.p[0] = trpt->bup.oval;
		;
		goto R999;

	case 23: // STATE 19
		;
		p_restor(II);
		;
		;
		goto R999;
	}

