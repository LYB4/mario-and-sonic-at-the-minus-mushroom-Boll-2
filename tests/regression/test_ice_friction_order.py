"""Regression checks for ice ground friction ordering (issue #60).

GameMaker has no headless test runner in this repo, so these tests validate
the GML source structure that the ice-physics fix depends on.
"""
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]

MARIO_PATHS = [
    REPO_ROOT / "Boll 2/datafiles/_vanilla/character/mario/mario.gml",
    REPO_ROOT / "playable_build/_vanilla/character/mario/mario.gml",
]

SONIC_PATHS = [
    REPO_ROOT / "Boll 2/datafiles/_vanilla/character/sonic/sonic.gml",
    REPO_ROOT / "playable_build/_vanilla/character/sonic/sonic.gml",
]

CHARMS_PATH = REPO_ROOT / "Boll 2/scripts/component_charms/component_charms.gml"


def _active_line_index(lines: list[str], needle: str) -> int | None:
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith("//"):
            continue
        if needle in stripped:
            return i
    return None


def _ground_friction_before_multiply(text: str, label: str) -> None:
    lines = text.splitlines()
    ground_line = None
    mult_line = None
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith("//"):
            continue
        if "component_get_ground_friction()" in stripped:
            ground_line = i
        if stripped.startswith("fric = fric * friction_mult"):
            mult_line = i
    assert ground_line is not None, f"{label}: missing component_get_ground_friction()"
    assert mult_line is not None, f"{label}: missing fric = fric * friction_mult"
    assert ground_line < mult_line, (
        f"{label}: component_get_ground_friction() must run before "
        "fric = fric * friction_mult"
    )


def test_mario_samples_ground_friction_before_multiply() -> None:
    for path in MARIO_PATHS:
        _ground_friction_before_multiply(path.read_text(), path.name)


def test_sonic_samples_ground_friction_before_multiply() -> None:
    for path in SONIC_PATHS:
        _ground_friction_before_multiply(path.read_text(), path.name)


def test_ground_friction_resets_multiplier() -> None:
    text = CHARMS_PATH.read_text()
    start = text.index("function component_get_ground_friction()")
    body = text[start : start + 400]
    assert "friction_mult = 1" in body, (
        "component_get_ground_friction must reset friction_mult before sampling"
    )


def test_sonic_skid_uses_reduced_fric_on_ice() -> None:
    text = CHARMS_PATH.read_text()
    start = text.index("function component_sonic_standing()")
    end = text.index("function component_get_ground_friction()")
    body = text[start:end]
    assert "skidding && friction_mult < 1" in body, (
        "Sonic standing decel should scale down while skidding on ice"
    )


if __name__ == "__main__":
    tests = [
        test_mario_samples_ground_friction_before_multiply,
        test_sonic_samples_ground_friction_before_multiply,
        test_ground_friction_resets_multiplier,
        test_sonic_skid_uses_reduced_fric_on_ice,
    ]
    for test in tests:
        test()
        print(f"ok {test.__name__}")
    print(f"{len(tests)} passed")
