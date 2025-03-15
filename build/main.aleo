program zpass_merkle_8_family.aleo;

record ZPass:
    owner as address.private;
    issuer as address.private;
    root as field.private;

closure get_merkle_tree:
    input r0 as [field; 8u32];
    add r0[0u32] r0[1u32] into r1;
    hash.psd2 r1 into r2 as field;
    add r0[2u32] r0[3u32] into r3;
    hash.psd2 r3 into r4 as field;
    add r0[4u32] r0[5u32] into r5;
    hash.psd2 r5 into r6 as field;
    add r0[6u32] r0[7u32] into r7;
    hash.psd2 r7 into r8 as field;
    cast  r2 r4 r6 r8 into r9 as [field; 4u32];
    add r9[0u32] r9[1u32] into r10;
    hash.psd2 r10 into r11 as field;
    add r9[2u32] r9[3u32] into r12;
    hash.psd2 r12 into r13 as field;
    cast  r11 r13 into r14 as [field; 2u32];
    add r14[0u32] r14[1u32] into r15;
    hash.psd2 r15 into r16 as field;
    output r16 as field;
    output r14 as [field; 2u32];
    output r9 as [field; 4u32];

function get_merkle:
    input r0 as [field; 8u32].private;
    call get_merkle_tree r0 into r1 r2 r3;
    output r1 as field.private;
    output r2 as [field; 2u32].private;
    output r3 as [field; 4u32].private;

function issue:
    input r0 as signature.private;
    input r1 as [field; 8u32].private;
    input r2 as address.private;
    hash.psd2 r2 into r3 as field;
    assert.eq r1[0u32] r3;
    call get_merkle_tree r1 into r4 r5 r6;
    sign.verify r0 r2 r4 into r7;
    assert.eq r7 true;
    cast self.caller r2 r4 into r8 as ZPass.record;
    output r8 as ZPass.record;

function issue_child:
    input r0 as signature.private;
    input r1 as ZPass.record;
    input r2 as [field; 8u32].private;
    input r3 as address.private;
    sign.verify r0 r3 r1.root into r4;
    assert.eq r4 true;
    call get_merkle_tree r2 into r5 r6 r7;
    sign.verify r0 r3 r5 into r8;
    assert.eq r8 true;
    cast self.caller r3 r5 into r9 as ZPass.record;
    output r9 as ZPass.record;

function verify:
    input r0 as ZPass.record;
    input r1 as field.private;
    input r2 as [field; 3u32].private;
    add r1 r2[0u32] into r3;
    hash.psd2 r3 into r4 as field;
    add r4 r2[1u32] into r5;
    hash.psd2 r5 into r6 as field;
    add r6 r2[2u32] into r7;
    hash.psd2 r7 into r8 as field;
    assert.eq r8 r0.root;
    output true as boolean.private;
